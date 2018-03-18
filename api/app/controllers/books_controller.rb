require 'tempfile'
require 'action_dispatch/http/upload'

class BooksController < ApplicationController

  before_action :verify_token
  before_action :set_current_user
  before_action :allowed_only_staff, only: [:update, :destroy]
  before_action :set_user, only: [:find_readed_books_by_user, :find_added_books_by_user, :find_borrowed_books_by_user]
  before_action :set_book, only: [:show, :update, :destroy, :borrow,
                                  :delete_cover, :delete_content, :find_readers, :add_content]

  def index
    @books = Book.all
    @books = @books.title(filter_params[:title]) if filter_params[:title].present?
    @books = @books.title_starts_with(filter_params[:title_starts_with]) if filter_params[:title_starts_with].present?
    @books = @books.title_ends_witg(filter_params[:title_ends_with]) if filter_params[:title_ends_with].present?
    @books = @books.title_matches(filter_params[:title_matches]) if filter_params[:title_matches].present?
    @books = @books.isbn(filter_params[:isbn]) if filter_params[:isbn].present?
    @books = @books.isbn_starts_witg(filter_params[:isbn_starts_with]) if filter_params[:isbn_starts_with].present?
    @books = @books.isbn_ends_with(filter_params[:isbn_ends_with]) if filter_params[:isbn_ends_with].present?
    @books = @books.isbn_matches(filter_params[:isbn_matches]) if filter_params[:isbn_matches].present?
    render json: @books
  end

  def show
    render json: @book
  end

  def create
    begin
      @book = Book.new(book_params)
      if params[:content]
        @book.content = params[:content]
      end
      @current_user.books << @book
      @current_user.save
      render json: @book, status: :ok, location: @book
    rescue
      head :forbidden
    end
  end

  def update
    _params = update_book_params
    if update_book_params[:content]
      @book.content = update_book_params[:content]
    end
    if _params[:max_count]
      if @book.max_count < _params[:max_count]
        @book.available_count += _params[:max_count] - @book.max_count
      else
        if @book.available_count > _params[:max_count]
          return head :unprocessable_entity
        end
      end
    end
    if @book.update_attributes(update_book_params)
      render json: @book, status: :ok
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    head :ok
  end

  def save_content

  end

  def save_cover

  end

  def delete_cover
    @book.delete_cover!
    if @book.save
      head :ok
    else
      head :forbidden
    end
  end

  def delete_content
    @book.delete_content!
    if @book.save
      head :ok
    else
      head :forbidden
    end
  end

  # def add_content
  #   # tmp = FilelessIO.new(request.body.read)
  #   # content = tmp
  #   @book.content = request.body
  #   if @book.save
  #     render json: @book
  #   else
  #     render json: @book.errors, status: :unprocessable_entity
  #   end
  # end

  def borrow
    if @book.available_count == 0
      return head :unprocessable_entity
    end
    borrowing = Borrowing.new status: 'ordered'
    borrowing.book = @book
    borrowing.user = @current_user
    if borrowing.save
      render json: borrowing, status: :ok
    else
      render json: borrowing.errors, status: :ok
    end
  end

  def find_readed_books_by_user
    borrowings = @user.borrowings
    render json: borrowings.where(status: 'returned').or(borrowings.where(status: 'borrowed')).map {
        |borrowing| borrowing.book
    }.uniq
  end

  def find_borrowed_books_by_user
    borrowings = @user.borrowings
    render json: borrowings.where(status: 'returned').map {
        |borrowing| borrowing.book
    }.uniq
  end

  def find_added_books_by_user
    render json: @user.books
  end

  def find_readers
    render json: @book.borrowings.map {
        |borrowing| borrowing.user
    }.uniq
  end

  private
  def set_book
    begin
      @book = Book.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end

  def set_user
    @user = User.find(params[:id])
    if @user.nil?
      head :not_found
    end
  end

  def filter_params
    params.permit(
        :isbn, :isbn_starts_with, :isbn_ends_with, :isbn_matches, :title, :title_starts_with, :title_ends_with, :title_matches
    )
  end

  def book_params
    params.permit(
        :isbn, :title, :author, :publisher, :year,
        :annotations, :available_count, :max_count,
        :cover
    )
  end

  def update_book_params
    params.permit(
        :isbn, :title, :author, :publisher, :year,
        :annotations, :max_count,
        :cover
    )
  end

  # def get_file_from_request(request, file_name)
  #   file = Tempfile.new([File.basename(file_name, ".*"), File.extname(file_name)])
  #   Rails.logger.info "#{request.body.size}" # returns 130
  #   file.write(request.body.read)
  #   file
  # end
end
