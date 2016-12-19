class KindlesController < ApplicationController
  before_action :set_kindle, only: [:show, :update]

  # GET /kindles/:ASIN
  def show
    if @kindle.present?
      render json: @kindle
    else
      render json: nil, status: :not_found
    end
  end

  # POST /kindles
  def create
    @kindle = Kindle.new(asin: params[:id])

    if @kindle.save
      render json: @kindle, status: :created, location: @kindle
    else
      render json: @kindle.errors, status: :unprocessable_entity
    end
  end

  # PATCH /kindles/:ASIN
  def update
    if @kindle.fetch!
      if @kindle.save
        render json: @kindle
      else
        render json: @kindle.errors, status: :unprocessable_entity
      end
    else
      render json: @kindle.errors
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kindle
      @kindle = Kindle.find_by(asin: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def kindle_params
      params.require(:kindle)
    end
end
