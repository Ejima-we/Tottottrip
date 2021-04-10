class Users::UsersController < ApplicationController

  def show
    @user = current_user
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

  def favorite
    @user = User.find_by(id: params[:id])
    # userに関するデータを取得
    @favorites = Favorite.where(user_id: @user.id)
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :nickname, :profile)
  end
end
