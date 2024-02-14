class Api::V1::CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show update destroy ]

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
    @address = @customer.address.build(address_params)

    if @address.save
      render json: @address
    else
      render json: @address.errors, status: :unprocessable_entity
    end
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

  def customer_params
    params.require(:customer).permit()
  end

  def address_params
    params.require(:address).permit(:latitude, :longitude, :address)
  end
end
