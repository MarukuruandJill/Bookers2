class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]


  def index
    @users =User.all
    #@books = Book.all
    @book = Book.new
    @user = User.find(current_user.id)
  end


  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books

    #user_info_new_book
    #@user = User.find(params[:id])
    #@books = @user.books.all
  end

  def update
    #is_matching_login_user
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user)
    else
      #flash[:notice] = " errors prohibited this obj from being saved:"
      render :edit
    end
  end

  def edit
    #is_matching_login_user
    @user = User.find(params[:id])
  end

  #def new
    #@user = User.new(user_params)
    #if @user.save
      #redirect_to  user_path(current_user.id)#成功の場合
    #else
      #render "users/sign_up"#失敗の場合
    #end
  #end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image , :introduction)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to user_path(current_user)
    end
  end

end
