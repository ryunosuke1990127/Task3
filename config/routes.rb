Rails.application.routes.draw do
   # deviseGemで機能している認証設定など用のルーティング
  devise_for :users
  # aboutページ用のルーティング
  get 'home/about' => 'homes#about'
  # ユーザーのプロフィール設定用のルーティング
  resources :users, only: [:show, :edit, :update, :index, :create]
  # 本の投稿。削除等のルーティング
  resources :books, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  # ルートページの設定
  root to: "homes#top"
end
