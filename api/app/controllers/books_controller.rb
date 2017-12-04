class BooksController < ApplicationController

  before_action :set_book, only: [:show, :update, :destroy]

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

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
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
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def book_params
      params.require(:book).permit(:title, :author, :publisher, :year, :annotations)
    end
end
