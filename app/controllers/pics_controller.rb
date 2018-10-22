class PicsController < ApplicationController

  include CurrentUser
  before_action :load_pic, only: [:show, :update, :destroy]

  def index
    @pics = Pic.all
    render json: @pics
  end

  def show
    render json: @pic
  end

  def create
    @pic = Pic.new(pic_params)
    if @pic.save
      render json: @pic, status: :created, location: @pic
    else
      render json: { errors: @pic.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @pic.update(pic_params)
      render json: @pic
    else
      render json: { errors: @pic.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @pic.destroy
  end

  private

    def pic_params
      params.require(:pic).permit(:published, :title, :content, :javascript)
    end

    def load_pic
      @pic = Pic.find(params[:id])
    end

end
