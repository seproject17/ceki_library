require 'action_dispatch'

class UsersController < ApplicationController

  before_action :verify_token, except: [:login, :logout]
  before_action :set_current_user, except: [:login, :logout]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :allowed_only_admin, except: [:index, :show, :show_current, :update, :login, :logout, :show, :change_email, :change_password]
  before_action :allow_only_own_account, only: [:update]

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user, status: :ok
  end

  def show_current
    render json: @current_user, status: :ok
  end


  def create
    p user_params
    user = User.new(user_params)

    if user.save
      render json: user, status: :created, location: user
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end


  def update
    if @user.update_attributes(user_params)
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
    email = credentials_params['email']
    password = credentials_params['password']
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
    old_password = change_password_params['old_password']
    password = change_password_params['new_password']
    unless @current_user.authenticate(old_password)
      return head :forbidden
    end
    @current_user.password = password
    if @current_user.save
      return head :ok
    end
    head :forbidden
  end


  def change_email
    password = change_email_params['password']
    email = change_email_params['email']
    if email == @current_user.email
      return head :ok
    end
    unless @current_user.authenticate(password)
      return head :forbidden
    end
    @current_user.email = email
    if @current_user.save
      return head :ok
    end
    head :forbidden
  end

  def delete_avatar
    @current_user.remove_avatar!
    if @current_user.save
      head :ok
    else
      head :forbidden
    end
  end

  private
  def set_user
    begin
      @user = User.find(params[:id])
    rescue
      head :not_found
    end
  end

  def allow_only_own_account
    unless @current_user.admin?
      begin
        if Integer(params[:id] || '') != @current_user.id
          render json: {'error': 'It is prohibited to manipulate with not own user account'}, status: :forbidden
        end
      rescue
        render json: {'error': 'Id is not integer'}, status: :forbidden
      end
    end
  end

  def user_params
    params.permit(:name, :surname, :email, :password, :role, :avatar)
  end

  def credentials_params
    params.permit(:email, :password)
  end

  def change_password_params
    params.permit(:old_password, :new_password)
  end

  def change_email_params
    params.permit(:password, :email)
  end
end
