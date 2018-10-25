class BlogPostsController < ApplicationController

  include CurrentUser

  def index
    if current_user
      @posts = Post.blogs.page(params[:page])
    else
      @posts = Post.published.blogs.page(params[:page])
    end
    render json: @posts, meta: { total_pages: @posts.total_pages, per_page: Post.default_per_page }
  end

end
