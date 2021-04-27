class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  # 管理者側バリデーション
  def authenticate_admin
    redirect_to new_admin_session_path if current_admin.nil?
  end

  # 会員側バリデーション
  def authenticate_user
    redirect_to new_user_session_path if current_user.nil? && current_admin.nil?
  end

  # ゲストユーザー側バリテーション
  def authenticate_guest_user
    redirect_to root_path unless current_user.nil? && (current_user.name == 'guest5gbcyjsozzkdyyb6')
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name nickname])
  end
end
