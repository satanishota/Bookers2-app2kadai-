class BooksController < ApplicationController
before_action :correct_user, only: [:edit,:update,:destroy]

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
    redirect_to book_path(@book), notice: "successfully"
    else
    flash.now[:alert] = "グループ名を入力してください"
    @user = current_user
    @books = Book.all
    render :index
    end

  end

  def index
    @user = current_user

    @books = Book.all
    @book = Book.new

  end

  def show
    @book = Book.find(params[:id])
    @booker = Book.new
  end

  def edit
    @booker = Book.find(params[:id])
  end


  def update
    @booker = Book.find(params[:id])
    @booker.user_id = current_user.id
    if @booker.update(book_params)
    redirect_to book_path(@booker), notice: "successfully"
    else

      render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

   private
  def book_params
    params.require(:book).permit(:title, :body)
  end
  def correct_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

end
