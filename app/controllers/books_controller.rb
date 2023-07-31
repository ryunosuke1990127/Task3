class BooksController < ApplicationController
  def new
    @book = Book.new
    byebug
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.user_id)
  end

  def index
    # 現在ログインしているユーザー情報を取得
     @user = current_user
    # 投稿したユーザーの一覧を表示するために全ての本情報を取得
     @books = Book.all
  end

  # book一覧内の本情報がクリックされた際の処理
  def show
    @book = Book.find(params[:id])
  end

  def edit
  end

  # 投稿データ用のストロングパラメータの設定
  private

   def book_params
     params.require(:book).permit(:title,:body)
   end
end
