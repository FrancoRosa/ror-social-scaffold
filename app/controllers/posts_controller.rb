class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    # @timeline_posts ||= Post.all.ordered_by_most_recent.includes(:user)
    posts = []

    posts += current_user.posts
    current_user.friends.each { |friend| posts += friend.posts }

    @timeline_posts ||= posts.uniq.sort { |a, b| a.created_at <=> b.created_at }.reverse
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
