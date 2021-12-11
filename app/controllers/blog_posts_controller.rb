class BlogPostsController < BaseController

  before_action :load_post, only: [:show, :update, :destroy]

  def index
    if current_user
      @posts = params[:tags].present? ? Post.blogs.tagged_with(params[:tags]).page(params[:page]).per(params[:per_page]) : Post.blogs.page(params[:page]).per(params[:per_page])
    else
      @posts = params[:tags].present? ? Post.published.blogs.tagged_with(params[:tags]).page(params[:page]).per(params[:per_page]) : Post.published.blogs.page(params[:page]).per(params[:per_page])
    end
    render json: @posts, root: :blog_posts, meta: { page: params[:page].to_i, total_pages: @posts.total_pages, per_page: Post.default_per_page, tag_list: Post.tag_counts_on(:tags) }
  end

  def show
    render json: @post, root: :blog_post
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: @post, status: :created, location: @post, root: :blog_post
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      render json: @post, root: :blog_post
    else
      render json: { errors: @post.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
  end

  private

    def post_params
      params.require(:blog_post).permit(:published, :permalink, :blog, :title, :content, tag_list: [])
    end

    def load_post
      @post = Post.find_by(permalink: params[:id])
    end

end
