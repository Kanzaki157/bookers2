class UsersController < ApplicationController
  def show
    @books = Book.new
    @user = User.find(params[:id])
    @book = @user.books
  end
  
  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end
  
  def edit
    @user = User.find(params[:id])
    redirect_to(user_path(current_user)) unless @user == current_user
  end
  
  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else
      flash[:alret] = "error"
    @users = User.all
    @user = current_user
    @book = Book.new
    render :index
    end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have created book successfully."
    redirect_to user_path(@user.id)
    else
    flash[:alret] = "error"
    render :edit
    end
  end
  
  
  private
  # ストロングパラメータ
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  
end
