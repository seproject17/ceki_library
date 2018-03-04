class BooksController < ApplicationController

  before_action :verify_token
  before_action :set_current_user
  before_action :allowed_only_staff, only: [:update, :destroy]
  before_action :set_user, only: [:find_readed_books_by_user, :find_added_books_by_user, :find_borrowed_books_by_user]
  before_action :set_book, only: [:show, :update, :destroy, :borrow,
                                  :delete_cover, :delete_content, :find_readers]

  def index
    @books = Book.all
    render json: @books
  end

  def show
    render json: @book
  end

  def create
    begin
      @book = Book.new(book_params)
      @current_user.books << @book
      @current_user.save
      render json: @book, status: :ok, location: @book
    rescue
      head :forbidden
    end
  end

  def update
    begin
      if @book.update_attributes(book_params)
        render json: @book, status: :ok
      else
        render json: @book.errors, status: :unprocessable_entity
      end
    rescue
      head :forbidden
    end
  end

  def destroy
    @book.destroy
    head :ok
  end


  def delete_cover
    @book.delete_cover!
    if @book.save
      head :ok
    else
      head :forbidden
    end
  end

  def delete_content
    @book.delete_content!
    if @book.save
      head :ok
    else
      head :forbidden
    end
  end

  def borrow
    if @book.available_count == 0
      return head :forbidden
    end
    borrowing = Borrowing.new status: 'ordered'
    borrowing.book = @book
    borrowing.user = @current_user
    if borrowing.save
      render json: borrowing, status: :ok
    else
      render json: borrowing.errors, status: :ok
    end
  end

  def find_readed_books_by_user
    borrowings = @user.borrowings
    render json: borrowings.where(status: 'returned').or(borrowings.where(status: 'borrowed')).map {
        |borrowing| borrowing.book
    }.uniq
  end

  def find_borrowed_books_by_user
    borrowings = @user.borrowings
    render json: borrowings.where(status: 'returned').map {
        |borrowing| borrowing.book
    }.uniq
  end

  def find_added_books_by_user
    render json: @user.books
  end

  def find_readers
    render json: @book.borrowings.map {
      |borrowing| borrowing.user
    }.uniq
  end

  private
  def set_book
    begin
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def set_user
    @user = User.find(params[:id])
    if @user.nil?
      head :not_found
    end
  end

  def book_params
    params.require(:book).permit(
        :isbn, :title, :author, :publisher, :year,
        :annotations, :available_count, :max_count,
        :cover, :content
    )
  end
end
