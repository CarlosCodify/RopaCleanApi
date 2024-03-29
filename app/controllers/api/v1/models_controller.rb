class Api::V1::ModelsController < ApplicationController
  before_action :set_model, only: %i[ show update destroy ]
  before_action :set_brand, only: %i[ index ]

  # GET /api/v1/models
  def index
    @models = @brand.models

    render json: @models
  end

  # GET /api/v1/models/1
  def show
    render json: @model
  end

  # POST /api/v1/models
  def create
    @model = Model.new(model_params)

    if @model.save
      render json: @model, status: :created
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/models/1
  def update
    if @model.update(model_params)
      render json: @model
    else
      render json: @model.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/models/1
  def destroy
    @model.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_model
      @model = Model.find(params[:id])
    end

    def set_brand
      @brand = Brand.find(params[:brand_id])
    end

    # Only allow a list of trusted parameters through.
    def model_params
      params.require(:model).permit(:name, :year, :brand_id)
    end
end
