class ReviewsController < ApplicationController

  before_action :verify_token
  before_action :set_review, only: [:show, :update, :destroy]
  before_action :set_book, only: [:create, :find_book_reviews]

  # GET /reviews
  api :GET, '/reviews', 'Find all reviews'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def index
    @reviews = Review.all
    render json: @reviews
  end

  # GET /reviews/1
  api :GET, '/review/:id', 'Find review'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def show
    render json: @review
  end

  # POST /books/1/reviews
  api :POST, '/reviews', 'Create review'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
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

  # PATCH/PUT /reviews/1
  api :PUT, '/reviews', 'Update review'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def update
    if @review.update(review_params)
      render json: @review
    else
      render json: @review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reviews/1
  api :DELETE, '/review', 'Delete review'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def destroy
    @review.destroy
  end

  # GET /books/1/reviews
  api :DELETE, '/review', 'Find book reviews'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
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
