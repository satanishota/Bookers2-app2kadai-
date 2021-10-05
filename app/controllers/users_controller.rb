class UsersController < ApplicationController
  before_action :correct_user, only: [:edit,:update,:destroy]

  def show
     @user = User.find(params[:id])
     @user2 = current_user
     @books = @user.books
     @book = Book.new
  end

  def edit
     @user = User.find(params[:id])
  end


  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to books_path
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
     redirect_to user_path(@user.id), notice: "successfully"
    else
       flash.now[:alert] = "入力してください"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  def book_params
    params.require(:book).permit(:title, :body)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user.id == current_user.id

      redirect_to user_path(current_user.id)
    end
  end

end
