class UsersController < ApplicationController
  def show
    # ログインした情報をもとにユーザーのしぃ王祭画面を表示
    @user = User.find(params[:id])
    @book = @user.book
    byebug
  end

  def edit
  end
end
