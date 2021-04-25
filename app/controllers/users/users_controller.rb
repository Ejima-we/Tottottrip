class Users::UsersController < ApplicationController

  before_action :authenticate_user
  before_action :authenticate_guest_user

  def show
    @user = current_user
    @posts = Post.where(user_id: @user.id)
    @favorites = Favorite.where(user_id: @user.id)
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to mypage_path
    else
      render :edit
    end
  end

  def leave
    @user = current_user
  end

  def withdraw
    @user = current_user
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :nickname, :profile)
  end
end
