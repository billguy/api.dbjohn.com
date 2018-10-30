class BlogPostsController < PostsController

  def index
    if current_user
      @posts = params[:tags].present? ? Post.blogs.tagged_with(params[:tags]).page(params[:page]) : Post.blogs.page(params[:page])
    else
      @posts = params[:tags].present? ? Post.published.blogs.tagged_with(params[:tags]).page(params[:page]) : Post.published.blogs.page(params[:page])
    end
    render json: @posts, meta: { page: params[:page].to_i, total_pages: @posts.total_pages, per_page: Post.default_per_page, tag_list: Post.tag_counts_on(:tags) }, root: root
  end

  private

    def require_param
      :blog_post
    end

    def root
      :blog_posts
    end

end
