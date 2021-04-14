class Users::HomesController < ApplicationController

  def top
    @genres = Genre.all
    @posts_rank = Post.find(Favorite.group(:post_id).order("count(post_id)desc").limit(3).pluck(:post_id))
    @posts = Post.all.order(created_at: :desc).page(params[:page]).per(4)
  end

  def about
  end

end
