class Api::V1::CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show update destroy]
  before_action :set_user, only: %i[ address add_address order_list]

  # GET /api/v1/customers
  def index
    @customers = Customer.includes(:person).all

    render json: @customers.map { |m| custom_json(m) }
  end

  # GET /api/v1/customers/1
  def show
    render json: @customer
  end

  # PATCH/PUT /api/v1/customers/1
  def update
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/customers/1
  def destroy
    @customer.destroy
  end

  def add_address
    @customer = @user.person.customer
    @address = @customer.addresses.build(address_params)

    if @address.save
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
  end

  def address
    @customer = @user.person.customer
    addresses = @customer.addresses

    render json: addresses
  end

  def order_list
    @customer = @user.person.customer
    address_ids = @customer.addresses.pluck(:id)
    @orders = Order.where(pickup_address_id: address_ids).or(Order.where(delivery_address_id: address_ids))

    render json: @orders.map { |order|
      order.as_json(include: [ :order_status, :payment_status, :pickup_address, :delivery_address,
                               :payments, clothing_inventories: { include: :clothing_type },
                               driver: { include: :person }, customer: { include: :person }])
    }
  end

  def address_show
    @address = Address.find(params[:id])

    render json: @address
  end

  private

  def custom_json(customer)
    customer_attrs = customer.attributes.except("created_at", "updated_at")
    person_attrs = customer.person.attributes.except("id", "created_at", "updated_at")
    customer_attrs.merge(person_attrs)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit()
  end

  def address_params
    params.require(:address).permit(:latitude, :longitude, :address)
  end
end
