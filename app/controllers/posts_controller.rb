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
    render json: @posts, meta: { page: params[:page].to_i, total_pages: @posts.total_pages, per_page: Post.default_per_page, tag_list: Post.tag_counts_on(:tags) }
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

    def require_param
      :post
    end

    def post_params
      params.require(require_param).permit(:published, :permalink, :blog, :title, :content, :tag_list)
    end

    def load_post
      @post = Post.find_by(permalink: params[:id])
    end

end
