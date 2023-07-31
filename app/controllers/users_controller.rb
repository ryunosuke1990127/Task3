class UsersController < ApplicationController
  def show
    #ログインしているユーザーの情報を
    @user = User.find(params[:id])
    @book = @user.book
  end

  def edit
  end
end
