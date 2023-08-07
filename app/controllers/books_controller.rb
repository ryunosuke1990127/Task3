class BooksController < ApplicationController
  # ログインしていないユーザが編集使用とした時の判定
  before_action :is_matching_login_user, only: [:edit, :update]

  # Create Bookを押した際の処理
  def create
    @book = Book.new(book_params)
    # ログインしているユーザーを紐づける
    @book.user_id = current_user.id
    if @book.save
    flash[:notice] = "You have updated user successfully."
    redirect_to book_path(@book.id)
    else
      # エラーが発生した際のrender先のView設定用のインスタンスをセット
      @user = current_user
      @books = Book.all
      # エラー時は一覧ページへ
      render :index
    end
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
    @books = Book.find(params[:id])
  end

  # Book詳細画面にてupdateをクリックした際の処理
  def update
    @books = Book.find(params[:id])
    if @books.update(book_params)
    flash[:notice] = "You have updated book successfully."
    redirect_to book_path
    else
      render:edit
    end
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

   def is_matching_login_user
     @book = Book.find(params[:id])
    unless @book.user.id==current_user.id
       redirect_to books_path
    end
   end
end
