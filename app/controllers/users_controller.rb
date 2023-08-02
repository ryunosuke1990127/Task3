class UsersController < ApplicationController
   def index
    # ユーザーページ内のcreateアクションを実行する時用のBookインスタンスをセット
     @book = Book.new
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
    redirect_to users_path
  end

  # ログインしたユーザーページから新しい本を投稿するためのCreateアクションを定義
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    byebug
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

end
