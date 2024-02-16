class Api::V1::MotorcyclesController < ApplicationController
  before_action :set_motorcycle, only: %i[ show update destroy ]

  # GET /api/v1/motorcycles
  def index
    @motorcycles = Motorcycle.all

    render json: @motorcycles.map { |motorcycle|
      motorcycle.as_json(include: {
        model: {
          include: :brand
        },
        driver: {
          include: :person
        }
      })
    }
  end

  def list
    @motorcycles = Motorcycle.without_driver

    render json: @motorcycles.map { |motorcycle|
      motorcycle.as_json(include: {
        model: {
          include: :brand
        }
      })
    }
  end

  # GET /api/v1/motorcycles/1
  def show
    render json: @motorcycle
  end

  # POST /api/v1/motorcycles
  def create
    @motorcycle = Motorcycle.new(motorcycle_params)

    if @motorcycle.save
      render json: @motorcycle, status: :created
    else
      render json: @motorcycle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/motorcycles/1
  def update
    if @motorcycle.update(motorcycle_params)
      render json: @motorcycle
    else
      render json: @motorcycle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/motorcycles/1
  def destroy
    @motorcycle.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_motorcycle
      @motorcycle = Motorcycle.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def motorcycle_params
      params.require(:motorcycle).permit(:status, :license_plate, :model_id)
    end
end
