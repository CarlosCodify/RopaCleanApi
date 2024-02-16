class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[ show update destroy ]
  CHARACTER_SET = [*'0'..'9', *'a'..'z', *'A'..'Z'].freeze

  # GET /api/v1/users
  def index
    @users = User.all

    render json: @users
  end

  # GET /api/v1/users/1
  def show
    render json: @user.as_json(include: [ :person ])
  end

  # POST /api/v1/users
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def register
    @user = User.new(user_params)
    person = @user.build_person(person_params)
    person.role = 'customer'
    customer = person.build_customer(code: create_code)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def create_code
      (0...8).map { CHARACTER_SET.sample }.join
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :nickname, :password, :password_confirmation)
    end

    def person_params
      params.require(:person).permit(:first_name, :last_name, :phone, :email)
    end
end
