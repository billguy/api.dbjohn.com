class PostsController < ApplicationController

  include CurrentUser
  before_action :load_post, only: [:show, :update, :destroy]

  def index
    @posts = Post.all
    render json: @posts
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
      params.require(:post).permit(:published, :title, :content, :javascript)
    end

    def load_post
      @post = Post.find(params[:id])
    end

end
