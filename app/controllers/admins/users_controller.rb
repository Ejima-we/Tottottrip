class Admins::UsersController < ApplicationController
  before_action :authenticate_admin

  def index
    @users = User.all.order(created_at: 'DESC').page(params[:page]).per(30)
    @guest_user = User.where(name: 'guest5gbcyjsozzkdyyb6')
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admins_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.where(name: 'guest5gbcyjsozzkdyyb6')
    @user.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def user_params
    params.require(:user).permit(:name, :nickname, :profile, :is_deleted)
  end
end
