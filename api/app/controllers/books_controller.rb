class BooksController < ApplicationController

  before_action :verify_token
  before_action :set_current_user
  before_action :allowed_only_staff, only: [:update, :destroy]
  before_action :set_book, only: [:show, :update, :destroy, :borrow, :return]

  # GET /books
  api :GET, '/books', 'Get all books'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def index
    @books = Book.all
    render json: @books
  end

  # GET /books/1
  api :GET, '/books/:id', 'Find book by id'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def show
    render json: @book
  end

  # POST /books
  api :POST, '/books', 'Create book'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found', :meta => {:anything => 'you can think of'}

  def create
    @book = Book.new(book_params)
    @current_user.books << @book
    @current_user.save
    #
    # if @book.save
    #   render json: @book, status: :created, location: @book
    # else
    #   render json: @book.errors, status: :unprocessable_entity
    # end
    render json: @book, status: :ok, location: @book
  end

  # PATCH/PUT /books/1
  api :PUT, '/books/:id', 'Update book'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /books/1
  api :DELETE, '/books/:id', 'Delete book'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def destroy
    @book.destroy
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
  # Use callbacks to share common setup or constraints between actions.
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

  # Only allow a trusted parameter "white list" through.
  def book_params
    params.require(:book).permit(:title, :author, :publisher, :year, :annotations)
  end
end
