Rails.application.routes.draw do
  devise_for :users
  # ルートページの設定
  root to: "homes#top"
end
