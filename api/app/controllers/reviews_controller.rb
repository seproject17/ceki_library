class ReviewsController < ApplicationController

  before_action :verify_token
  before_action :set_current_user
  before_action :set_review, only: [:show, :update, :destroy]
  before_action :set_book, only: [:create, :find_by_book]
  before_action :set_user, only: [:find_by_user]

  def show
    render json: @review
  end

  def create
    @review = Review.new(review_params)
    @review.book = @book
    @review.user = @current_user
    if @review.save
      render json: @review, status: :ok
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def update
    if @review.update(review_params)
      render json: @review, status: :ok
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    head :ok
  end

  def find_by_user
    render json: @user.reviews, status: :ok
  end

  def find_by_book
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

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def review_params
    params.require(:review).permit(:comments, :mark)
  end
end
