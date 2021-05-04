class Admins::PostsController < ApplicationController

  def index
    @posts = Post.all.order(created_at: "DESC").page(params[:page]).per(30)
  end
end
