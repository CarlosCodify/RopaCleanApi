class Api::V1::OrdersController < ApplicationController
  before_action :set_order, only: %i[ show update destroy ]

  # GET /api/v1/orders
  def index
    @orders = Order.all

    render json: @orders.as_json(include: [ :order_status, :payment_status, :pickup_address, :delivery_address ])
  end

  # GET /api/v1/orders/1
  def show
    render json: @order
  end

  # POST /api/v1/orders
  def create
    @order = Order.new(order_params)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:pickup_address_id, :delivery_address_id, :scheduled_date_time,
                                    :pickup_date_time, :delivery_date_time, :total_amount, :notes)
    end
end
