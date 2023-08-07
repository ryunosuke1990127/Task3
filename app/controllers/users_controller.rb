class UsersController < ApplicationController
    # ログインしていないユーザが編集使用とした時の判定
    before_action :is_matching_login_user, only: [:update]
   def index
    # 現在ログインしているUserInfoを取得
    @user = current_user
    # ユーザーページ内のcreateアクションを実行する時用のBookインスタンスをセット
     @book = Book.new
    # Bookersを利用しているユーザー一覧を取得
    @users = User.all
   end

  def show
    # ユーザーページ内のcreateアクションを実行する時用のBookインスタンスをセット
     @book = Book.new
    #ログインしているユーザーの情報を取得
    @user = User.find(params[:id])
    # ユーザーの情報を取得
    @user_book = @user.books
  end

 # ユーザーの編集ページをクリックした際の機能
  def edit
     @user = User.find(params[:id])
      # ログインしているユーザー以外が編集ボタンをクリックした際の処理
     unless @user.id==current_user.id
       redirect_to user_path(current_user.id)
     end
  end

  # ユーザーの編集画面にて更新を押した際の処理
  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
    flash[:notice] = "You have updated user successfully."
    redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  # ログインしたユーザーページから新しい本を投稿するためのCreateアクションを定義
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  private
  # ユーザー編集用のストロングパラメータをセット
  def user_params
    params.require(:user).permit(:name, :profile_image,:introduction)
  end

  #　本をCreateする際のストロングパラメータの設定
  def book_params
     params.require(:book).permit(:title,:body)
  end

  def is_matching_login_user
    @user = User.find(params[:id])
    unless @user.id==current_user.id
       redirect_to books_path
    end
  end

end
