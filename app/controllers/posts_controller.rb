class PostsController < ApplicationController

  include CurrentUser

  before_action :authorize_access_request!, only: [:create, :update, :destroy]
  before_action :load_post, only: [:show, :update, :destroy]

  def index
    if current_user
      @posts = Post.pages.page(params[:page])
    else
      @posts = Post.pages.published.page(params[:page])
    end
    render json: @posts, meta: { total_pages: @posts.total_pages, per_page: Post.default_per_page }
  end

  def show
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  private

    def post_params
      params.require(:post).permit(:published, :blog, :title, :content, :javascript)
    end

    def load_post
      @post = Post.find_by(permalink: params[:id])
    end

    def pagination(paginated_array, per_page)
      {
        page: params[:page].to_i,
        per_page: per_page.to_i,
        total_pages: paginated_array.total_pages,
        total_objects: paginated_array.total_count
      }
    end

end
