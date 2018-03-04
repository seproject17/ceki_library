class BorrowingsController < ApplicationController
  before_action :verify_token
  before_action :set_current_user
  before_action :allowed_only_staff, except: [:index, :show, :find_by_user, :find_by_current_user]
  before_action :set_borrowing, only: [:show, :accept, :borrow, :reject, :return]
  before_action :set_user, only: [:find_by_user]

  def index
    render json: Borrowing.all
  end

  def show
    render json: @borrowing
  end

  def find_by_user
    render json: @user.borrowings
  end

  def find_by_current_user
    render json: @current_user.borrowings
  end

  def accept
    if %w(returned borrowed).include? @borrowing.status
      head :forbidden
    else
      @borrowing.status = 'accepted'
      if @borrowing.save
        render json: @borrowing, status: :ok
      else
        render json: @borrowing.errors, status: :forbidden
      end
    end
  end

  def borrow
    if %w(rejected borrowed returned).include? @borrowing.status
      head :forbidden
    elsif @borrowing.book.available_count == 0
      head :forbidden
    else
      @borrowing.status = 'borrowed'
      @borrowing.book.available_count -= 1
      @borrowing.borrow_date = Date.today
      if @borrowing.book.save and @borrowing.save
        render json: @borrowing, status: :ok
      else
        render json: @borrowing.errors, status: :forbidden
      end
    end
  end

  def reject
    if %w(returned borrowed).exclude? @borrowing.status
      @borrowing.status = 'rejected'
      if @borrowing.save
        render json: @borrowing, status: :ok
      else
        render json: @borrowing.errors, status: :forbidden
      end
    else
      head :forbidden
    end
  end

  def return
    if @borrowing.status != 'borrowed'
      head :forbidden
    elsif @borrowing.book.available_count == @borrowing.book.max_count
      head :forbidden
    else
      @borrowing.status = 'returned'
      @borrowing.book.available_count += 1
      @borrowing.return_date = Date.today
      if @borrowing.book.save and @borrowing.save
        render json: @borrowing, status: :ok
      else
        render json: @borrowing.errors, status: :forbidden
      end
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
    if @user.nil?
      head :not_found
    end
  end

  def set_borrowing
    @borrowing = Borrowing.find(params[:id])
    unless @borrowing
      head :not_found
    end
  end
end