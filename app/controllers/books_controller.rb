class BooksController < ApplicationController
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
      flash[:alret] = "error"
      @books = Book.all
      @user = current_user
      render :index
    end
  end
  
  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end
  
  def edit
    @book = Book.find(params[:id])
    redirect_to books_path unless @book.user == current_user
  end
  
  def show
    @book = Book.find(params[:id])
    @booknew = Book.new
     @user = @book.user
  end
  
  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to '/books'
  end
  
  def update
    @book = Book.find(params[:id])
    if  @book.update(book_params)
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@book.id)
    else
      flash[:alret] = "error"
      render :edit
    end
  end
  
  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
  def correct_user
    @book = Book.find(params[:id])
    @user = @book.user
    redirect_to(books_path) unless @user == current_user
  end
  
end
