class Api::V1::BrandsController < ApplicationController
  before_action :set_brand, only: %i[ show update destroy ]

  # GET /api/v1/brands
  def index
    @brands = Brand.all

    render json: @brands
  end

  # GET /api/v1/brands/1
  def show
    render json: @brand
  end

  # POST /api/v1/brands
  def create
    @brand = Brand.new(brand_params)

    if @brand.save
      render json: @brand, status: :created
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/brands/1
  def update
    if @brand.update(brand_params)
      render json: @brand
    else
      render json: @brand.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/brands/1
  def destroy
    @brand.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brand
      @brand =Brand.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def brand_params
      params.require(:brand).permit(:name)
    end
end
