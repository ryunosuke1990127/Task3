class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top]
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後はユーザーの詳細画面へ
  def after_sign_in_path_for(resource)
    user_path(@user.id)
  end

  # ログアウト後はTopページへ
  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
end
