class BooksController < ApplicationController

  before_action :verify_token
  before_action :set_current_user
  before_action :allowed_only_staff, only: [:update, :destroy]
  before_action :set_book, only: [:show, :update, :destroy, :borrow, :return,
                                  :upload_base64_cover, :upload_base64_content,
                                  :delete_cover, :delete_content]

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
    updated_book = JSON.parse request.body.read
    begin
      if @book.update_attributes(updated_book)
        render json: @book
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

  def upload_base64_cover
    @book.cover = JSON.parse(request.body.string)['cover']
    unless @book.save
      return head :forbidden
    end
    head :ok
  end

  def upload_base64_content
    @book.content = JSON.parse(request.body.string)['content']
    unless @book.save
      return head :forbidden
    end
    head :ok
  end

  def delete_cover
    begin
      @book.delete_cover
    rescue
      head :forbidden
    end
    head :ok
  end

  def delete_content
    begin
      @book.delete_content
    rescue
      head :forbidden
    end
    head :ok
  end

  def borrow
    p 'Borrowing'
    if @book.available_count == 0
      return head :forbidden
    end
    borrowing = Borrowing.new borrow_date: Date.today, status: 'borrowed'
    borrowing.book = @book
    borrowing.user = @current_user
    borrowing.save
    @book.available_count -= 1
    @book.save
    head :ok
  end

  def return
    p 'Return'
    if @book.available_count + 1 > @book.max_count
      return head :forbidden
    end
    unless @book.borrowings.exists?(status: 'borrowed', user_id: @current_user.id)
      return head :forbidden
    end
    borrowing = (@book.borrowings.where(status: 'borrowed', user_id: @current_user.id).last(1))[0]
    borrowing.status = 'returned'
    borrowing.actual_date = Date.today
    borrowing.save
    head :ok
  end

  private
  def set_book
    @book = Book.find(params[:id])
    if @book.nil?
      head :not_found
    end
  end

  def set_user
    @user = User.find(params[:user_id])
    if @book.nil?
      head :not_found
    end
  end

  def book_params
    params.require(:book).permit(:title, :author, :publisher, :year, :annotations)
  end
end
