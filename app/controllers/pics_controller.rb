class PicsController < BaseController

  before_action :load_pics, only: :index
  before_action :load_pic, only: [:show, :update, :destroy]

  def index
    @pics = @pics.page(params[:page]).per(params[:per_page])
    render json: @pics, meta: { page: params[:page].to_i, total_pages: @pics.total_pages, per_page: Pic.default_per_page, tag_list: Pic.tag_counts_on(:tags) }
  end

  def show
    render json: @pic, action: :show, current_user: current_user
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

    def load_pics
      @pics = params[:tags].present? ? pics_with_tags : pics
    end

    def load_pic
      @pic = Pic.find_by(permalink: params[:id])
    end

    def pics_with_tags
      if current_user
        Rails.cache.fetch("pics-with-photos-and-tags-#{params[:tags]}"){ Pic.with_photos_and_tags.tagged_with(params[:tags]) }
      else
        Rails.cache.fetch("pics-with-photos-and-tags-published-#{params[:tags]}"){ Pic.with_photos_and_tags.published.tagged_with(params[:tags]) }
      end
    end

    def pics
      if current_user
        Rails.cache.fetch("pics-with-photos-and-tags"){ Pic.with_photos_and_tags }
      else
        Rails.cache.fetch("pics-with-photos-and-tags-published"){ Pic.with_photos_and_tags.published }
      end
    end

end
