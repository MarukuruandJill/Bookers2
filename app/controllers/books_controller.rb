class BooksController < ApplicationController
  #before_action :is_matching_login_user, only: [:edit, :update]
  #before_action :user_info_new_book, only: [:index, :show]
  before_action :authenticate_user!,　except: [:top, :about]
  before_action :correct_post,only: [:edit]
  #before_action :ensure_current_user, {only: [:edit,:update,:destroy]}

  def index
    #user_info_new_book
    @books = Book.all
    @user = User.find(current_user.id)
    @book = Book.new
  end

  def show
    #user_info_new_book
    @book_new = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
    @book_comment = BookComment.new
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      @user = current_user
      @books = Book.all
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end



  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  #def user_params
    #params.require(:user).permit(:name,:profile_image,:introduction)
  #end


  def is_matching_login_user
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def correct_post
        @book = Book.find(params[:id])
    unless @book.user.id == current_user.id
      redirect_to books_path
    end
end

end
