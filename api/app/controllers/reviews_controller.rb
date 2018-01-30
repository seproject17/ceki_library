class ReviewsController < ApplicationController

  before_action :verify_token
  before_action :set_review, only: [:show, :update, :destroy]
  before_action :set_book, only: [:create, :find_book_reviews]

  def index
    @reviews = Review.all
    render json: @reviews
  end

  def show
    render json: @review
  end

  def create
    @review = Review.new(JSON.parse request.body.string)
    @book << @review
    @book.save!
    if @review.save
      render json: @review, status: :created, location: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
  end

  def find_book_reviews
    render json: @book.reviews, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def review_params
      params.require(:review).permit(:text, :mark)
    end
end
