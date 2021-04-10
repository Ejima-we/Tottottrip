class Users::UsersController < ApplicationController
  
  def show
    @user = current_user
  end
  
  def edit
  end
  
  def update
  end
  
  def leave
  end
  
  def withdraw
  end
  
  def favorite
    @user = User.find_by(id: params[:id])
    # userに関するデータを取得
    @favorites = Favorite.where(user_id: @user.id)
  end
end
