class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[ show update destroy add_inventory add_payment update_status]

  # GET /api/v1/orders
  def index
    @orders = Order.all

    render json: @orders.map { |order|
      order.as_json(include: [ :order_status, :payment_status, :pickup_address, :delivery_address,
                               :payments, clothing_inventories: { include: :clothing_type },
                               driver: { include: :person }, customer: { include: :person }])
    }
  end

  def update_status
    order_status = OrderStatus.find_by(name: params[:order_status])

    if order_status.name == 'Orden entregada.'
      @order.update(order_status_id: 3, delivery_date_time: DateTime.now)
      @order.driver.update(status: true)
    elsif order_status.name == 'En camino a la lavanderia.'
      @order.update(order_status_id: order_status.id, pickup_date_time: DateTime.now)
    else
      @order.update(order_status_id: order_status.id)
    end

    render json: @order.as_json(include: [ :order_status, :payment_status, :pickup_address, :delivery_address,
                               :payments, clothing_inventories: { include: :clothing_type },
                               driver: { include: :person }, customer: { include: :person }])
  end

  def resume
    pending_orders = Order.where.not(order_status_id: 3).count
    closed_orders = Order.where(order_status_id: 3).count
    payments_totals = Payment.all.sum(:amount)
    drivers_availables = Driver.where(status: true).count
    data = {
      pending_orders: pending_orders,
      closed_orders: closed_orders,
      payments_totals: payments_totals,
      drivers_availables: drivers_availables
    }

    render json: data
  end

  # GET /api/v1/orders/1
  def show
    render json: @order.as_json(include: [ :order_status, :payment_status, :pickup_address, :delivery_address,
                                           :payments, clothing_inventories: { include: :clothing_type },
                                           driver: { include: :person }, customer: { include: :person }])
  end

  # POST /api/v1/orders
  def create
    @order = Order.new(order_params)
    @order.scheduled_date_time = DateTime.now + 24.hours
    drivers = Driver.where(status: true)
    latitude = @order.pickup_address.latitude
    longitude = @order.pickup_address.longitude
    closest_driver = find_closest_driver(drivers, latitude.to_d, longitude.to_d)
    @order.driver_id = closest_driver.id
    @order.order_status_id = 1
    @order.payment_status_id = 1

    if @order.save
      @order.driver.update(status: false)
      render json: @order, status: :created
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  def add_inventory
    clothing_inventory = @order.clothing_inventories.build(clothing_inventory_params)

    if clothing_inventory.save

      order = clothing_inventory.order
      amount = clothing_inventory.quantity * clothing_inventory.clothing_type.unit_price
      if order.total_amount == nil
        order.update(total_amount: amount )
      else
        order.update(total_amount: order.total_amount + amount )
      end
      order.update(order_status_id: 2)

      render json: clothing_inventory, status: :created
    else
      render json: clothing_inventory.errors, status: :unprocessable_entity
    end
  end

  def add_payment
    payment = @order.payments.build(payment_params)
    payment.date = DateTime.now

    if payment.save
      payment.order.update(payment_status_id: 2) if payment.order.total_amount > payment.amount
      payment.order.update(payment_status_id: 3) if payment.order.total_amount <=  payment.order.payments.sum(:amount)
      render json: payment, status: :created
    else
      render json: payment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/orders/1
  def update
    if @order.update(order_params)
      render json: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/orders/1
  def destroy
    @order.destroy
  end

  def clothing_types
    clothing_types = ClothingType.all

    render json: clothing_types
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:pickup_address_id, :delivery_address_id, :notes)
    end

    def clothing_inventory_params
      params.require(:clothing_inventory).permit(:quantity, :clothing_type_id)
    end

    def payment_params
      params.require(:payment).permit(:amount)
    end

    def distance(lat1, lon1, lat2, lon2)
      # Fórmula de Haversine

      dlon = lon2 - lon1
      dlat = lat2 - lat1
      a = Math.sin(dlat/2)**2 + Math.cos(lat1) * Math.cos(lat2) * Math.sin(dlon/2)**2
      c = 2 * Math.asin(Math.sqrt(a))
      # Radio de la Tierra en kilómetros
      r = 6371
      return c * r
    end

    def find_closest_driver(drivers, latitude, longitude)
      distances = drivers.map do |driver|
        { driver: driver, distance: distance(latitude, longitude, driver.latitude.to_d, driver.longitude.to_d) }
      end
      distances.sort_by! { |d| d[:distance] }
      return distances.first[:driver]
    end
end
