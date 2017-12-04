class EBooksController < ApplicationController
  before_action :set_e_book, only: [:show, :update, :destroy]

  # GET /e_books
  api :GET, '/e_books', 'Find all ebooks'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def index
    @e_books = EBook.all

    render json: @e_books
  end

  # GET /e_books/1
  api :GET, '/e_books/:id', 'Find ebook'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def show
    render json: @e_book
  end

  # POST /e_books
  api :POST, '/e_books', 'Create ebook'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def create
    @e_book = EBook.new(e_book_params)

    if @e_book.save
      render json: @e_book, status: :created, location: @e_book
    else
      render json: @e_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /e_books/1
  api :PUT, '/e_books/:id', 'Update ebook'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def update
    if @e_book.update(e_book_params)
      render json: @e_book
    else
      render json: @e_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /e_books/1
  api :DELETE, '/e_books/:id', 'Delete book'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def destroy
    @e_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_e_book
      @e_book = EBook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def e_book_params
      params.require(:e_book).permit(:title, :author, :publisher, :year, :annotations, :file_path)
    end
end
