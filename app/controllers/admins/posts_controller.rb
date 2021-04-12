class Admins::PostsController < ApplicationController

  def index
    @posts_all = Post.all.order(created_at: :desc)
    @posts = @posts_all.page(params[:page]).per(15)
  end

end
