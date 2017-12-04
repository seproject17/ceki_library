class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :update, :destroy]

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

  # POST /reviews
  api :POST, '/reviews', 'Create review'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def create
    @review = Review.new(review_params)

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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def review_params
      params.require(:review).permit(:text, :mark)
    end
end
