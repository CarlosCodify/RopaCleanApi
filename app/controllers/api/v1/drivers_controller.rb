class Api::V1::DriversController < ApplicationController
  before_action :set_driver, only: %i[ show update destroy]
  before_action :set_user, only: %i[ order order_list ]

  # GET /api/v1/drivers
  def index
    @drivers = Driver.includes(:person).all

    render json: @drivers.map { |m| custom_json(m) }
  end

  # GET /api/v1/drivers/1
  def show
    render json: @driver
  end

  # POST /api/v1/drivers
  def create
    @user = User.new(user_params)
    person = @user.build_person(person_params)
    person.role = 'driver'
    driver = person.build_driver(driver_params)
    driver.status = true

    if @user.save

      render json: person, status: :created
    else
      render json: driver.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/drivers/1
  def update
    if @driver.update(driver_params)
      render json: @driver
    else
      render json: @driver.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/drivers/1
  def destroy
    @driver.destroy
  end

  def order
    @order = @user.driver.orders.where.not(order_status_id: 3).last

    render json: @order.as_json(include: [ :order_status, :payment_status, :pickup_address, :delivery_address,
                                           :payments, clothing_inventories: { include: :clothing_type },
                                           driver: { include: :person }, customer: { include: :person }])
  end

  def order_list
    @orders = @user.driver.orders

    render json: @orders.map { |order|
      order.as_json(include: [ :order_status, :payment_status, :pickup_address, :delivery_address,
                               :payments, clothing_inventories: { include: :clothing_type },
                               driver: { include: :person }, customer: { include: :person }])
    }
  end

  private

  def custom_json(driver)
    driver_attrs = driver.attributes.except("created_at", "updated_at")
    person_attrs = driver.person.attributes.except("id", "created_at", "updated_at")
    driver_attrs.merge(person_attrs)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_driver
    @driver = Driver.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def driver_params
    params.require(:driver).permit(:driver_license, :identity_card, :motorcycle_id)
  end

  def user_params
    params.require(:user).permit(:email, :nickname, :password, :password_confirmation)
  end

  def person_params
    params.require(:person).permit(:first_name, :last_name, :phone, :email)
  end
end
