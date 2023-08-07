class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top,:about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  # ログインした後に今ログインしているユーザーの情報を常に取得しておく

  # ログイン後はユーザーの詳細画面へ
  def after_sign_in_path_for(resource)
    flash[:notice] = "Signed in successfully."
    user_path(current_user.id)
  end

  # ログアウト後はTopページへ
  def after_sign_out_path_for(resource)
    flash[:notice] = "Signed out successfully."
    root_path
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
