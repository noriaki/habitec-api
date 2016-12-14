class KindlesController < ApplicationController
  before_action :set_kindle, only: [:show, :update, :destroy]

  # GET /kindles
  def index
    @kindles = Kindle.all

    render json: @kindles
  end

  # GET /kindles/1
  def show
    render json: @kindle
  end

  # POST /kindles
  def create
    @kindle = Kindle.new(kindle_params)

    if @kindle.save
      render json: @kindle, status: :created, location: @kindle
    else
      render json: @kindle.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /kindles/1
  def update
    if @kindle.update(kindle_params)
      render json: @kindle
    else
      render json: @kindle.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kindles/1
  def destroy
    @kindle.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kindle
      @kindle = Kindle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def kindle_params
      params.require(:kindle).permit(:asin, :title, :publisher, :authors, :image_url, :publish_at)
    end
end
