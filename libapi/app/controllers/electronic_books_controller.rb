class ElectronicBooksController < ApplicationController
  before_action :set_electronic_book, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /electronic_books
  def index
    @electronic_books = ElectronicBook.all

    render json: @electronic_books
  end

  # GET /electronic_books/1
  def show
    render json: @electronic_book
  end

  # POST /electronic_books
  def create
    @electronic_book = ElectronicBook.new(electronic_book_params)

    if @electronic_book.save
      render json: @electronic_book, status: :created, location: @electronic_book
    else
      render json: @electronic_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /electronic_books/1
  def update
    if @electronic_book.update(electronic_book_params)
      render json: @electronic_book
    else
      render json: @electronic_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /electronic_books/1
  def destroy
    @electronic_book.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_electronic_book
      @electronic_book = ElectronicBook.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def electronic_book_params
      params.require(:electronic_book).permit(:title, :author, :publisher, :year, :annotations, :file_path)
    end
end
