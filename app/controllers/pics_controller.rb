class PicsController < ApplicationController

  include CurrentUser

  before_action :authorize_access_request!, only: [:create, :update, :destroy]
  before_action :load_pic, only: [:show, :update, :destroy]

  def index
    if current_user
      @pics = params[:tags].present? ? Pic.with_photos_and_tags.tagged_with(params[:tags]).page(params[:page]).per(params[:per_page]) : Pic.with_photos_and_tags.page(params[:page]).per(params[:per_page])
    else
      @pics = params[:tags].present? ? Pic.with_photos_and_tags.published.tagged_with(params[:tags]).page(params[:page]).per(params[:per_page]) : Pic.with_photos_and_tags.page(params[:page]).per(params[:per_page])
    end
    render json: @pics, meta: { page: params[:page].to_i, total_pages: @pics.total_pages, per_page: Pic.default_per_page, tag_list: Pic.tag_counts_on(:tags) }
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
      params.require(:pic).permit(:published, :title, :permalink, :caption, :photo, tag_list: [])
    end

    def load_pic
      @pic = Pic.find(params[:id])
    end

end
