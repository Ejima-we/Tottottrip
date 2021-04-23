class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 管理者側バリデーション
  def authenticate_admin
    if current_admin == nil
      redirect_to new_admin_session_path
    end
  end
  
  # 会員側バリデーション
  def authenticate_user
    if (current_user == nil) && (current_admin == nil)
      redirect_to new_user_session_path
    end
  end

  # ゲストユーザー側バリテーション
  def authenticate_guest_user
    if current_user != nil
      if current_user.name == "guest5gbcyjsozzkdyyb6"
        redirect_to root_path
      end
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname])
  end
end
