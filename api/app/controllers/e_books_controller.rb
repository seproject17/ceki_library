class EBooksController < ApplicationController
  before_action :set_e_book, only: [:show, :update, :destroy]

  # GET /e_books
  def index
    @e_books = EBook.all

    render json: @e_books
  end

  # GET /e_books/1
  def show
    render json: @e_book
  end

  # POST /e_books
  def create
    @e_book = EBook.new(e_book_params)

    if @e_book.save
      render json: @e_book, status: :created, location: @e_book
    else
      render json: @e_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /e_books/1
  def update
    if @e_book.update(e_book_params)
      render json: @e_book
    else
      render json: @e_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /e_books/1
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
