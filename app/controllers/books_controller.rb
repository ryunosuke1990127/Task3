class BooksController < ApplicationController
  # Create Bookを押した際の処理
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    @book.save
    redirect_to book_path(@book.id)
  end

  def index
    # Veiw側でBookモデルの情報を扱うためからのインスタンスをセット
     @book = Book.new
    # 現在ログインしているユーザー情報を取得
     @user = current_user
    # 投稿したユーザーの一覧を表示するために全ての本情報を取得
     @books = Book.all
  end

  # book一覧内の本情報がクリックされた際の処理
  def show
    # 現在ログインしているユーザー情報を取得
    @user = current_user
    # Veiw側でBookモデルの情報を扱うためからのインスタンスをセット
    @book = Book.new
    # 詳細をクリックした際の情報
    @books = Book.find(params[:id])
  end

  # Book詳細画面にて編集ボタンをクリックした際の画面遷移
  def edit
    @book_edit = Book.find(params[:id])
  end

  # Book詳細画面にてupdatをクリックした際の処理
  def update
    @books = Book.find(params[:id])
    @books.update(book_params)
    redirect_to book_path
  end

  # Book詳細画面にてDESTROYをクリックした際の処理
   def destroy
    @books = Book.find(params[:id])
    @books.destroy
    redirect_to books_path
   end

  # 投稿データ用のストロングパラメータの設定
  private
   def book_params
     params.require(:book).permit(:title,:body)
   end
end
