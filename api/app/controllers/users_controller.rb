require 'action_dispatch'

class UsersController < ApplicationController

  # before_action :set_user, only: [:show, :update, :destroy]

  before_action :verify_token, except: [:login, :logout]
  before_action :set_current_user, except: [:login, :logout]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :allowed_only_admin, except: [:index, :show, :show_current, :login, :logout, :show, :change_email, :change_password]

  def index
    @users = User.all
    render json: @users
  end

  def show
    user = User.find params[:id]
    render json: user, status: :ok
  end

  def show_current
    render json: @current_user, status: :ok
  end


  def create
    @user = User.new(JSON.parse request.body.string)

    if User.exists? :email => @user.email
      head :forbidden
    end

    if @user.save
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  def update
    updated_user = JSON.parse request.body.read
    updated_user.delete('role')
    updated_user.delete('password')
    updated_user.delete('email')
    if @user.update(updated_user)
      head :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end


  def destroy
    @user.destroy
    head :ok
  end


  def login
    credentials = JSON.parse request.body.string
    email = credentials['email']
    password = credentials['password']
    user = User.find_by_email email
    if user && user.authenticate(password)
      cookies[:token] = AuthToken.issue_token({'user_id': user.id})
      render json: user, status: :ok
    else
      head :unauthorized
    end
  end

  def logout
    cookies.delete :token
  end


  def change_password
    old_password = JSON.parse(request.body.string)['old_password']
    password = JSON.parse(request.body.string)['password']
    unless @current_user.authenticate(old_password)
      return head :forbidden
    end
    @current_user.password = password
    @current_user.save
    head :ok
  end


  def change_email
    password = JSON.parse(request.body.string)['password']
    email = JSON.parse(request.body.string)['email']
    if email == @current_user.email
      return head :ok
    end
    unless @current_user.authenticate(password)
      return head :forbidden
    end
    if User.exists? :email => email
      return head :forbidden
    end
    @current_user.email = email
    @current_user.save
    head :ok
  end

  private
  def set_user
    begin
      p 'Set user'
      @user = User.find(params[:id])
    rescue
      head :not_found
    end
  end

  def allow_only_own_account
    unless @current_user.admin?
      if params[:id] != @current_user.id
        render json: {'error': 'It is prohibited to manipulate with not own user account'}, status: :forbidden
      end
    end
  end
end
