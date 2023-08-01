class UsersController < ApplicationController
   def index
    # 現在ログインしているユーザー情報を取得
     @user = current_user
     @user_book = @user.books
     end

  def show
    #ログインしているユーザーの情報を取得
    @user = User.find(params[:id])
    @book = @user.book
  end

# ユーザーの編集ページをクリックした際の機能
  def edit
     @user = User.find(params[:id])
  end

  # ユーザーの編集画面にて更新を押した際の処理
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to books_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end
end
