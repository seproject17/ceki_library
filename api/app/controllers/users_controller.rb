require 'action_dispatch'

class UsersController < ApplicationController

  # before_action :set_user, only: [:show, :update, :destroy]

  before_action :verify_token, except: [:login, :logout]
  before_action :set_current_user, except: [:login, :logout]
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :allowed_only_admin, except: [:index, :show, :login, :logout, :show, :change_email, :change_password]

  # GET /users
  api :GET, '/users', 'Find all users'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def index
    @users = User.all.select :id, :name, :surname, :email, :role
    render json: @users
  end

  # GET /users/1
  api :GET, '/user/:id', 'Find user by id'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def show
    user = User.find params[:id]
    render json: {
        'id': user.id,
        'name': user.name,
        'surname': user.surname,
        'email': user.email,
        'role': user.role
    }, status: :ok
  end

  # GET /users/current
  api :GET, '/user', 'Get user'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def show_current
    render json: @current_user, status: :ok
  end

  # POST /users
  api :POST, '/users', 'Sign up user'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

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

  # PATCH/PUT /users/1
  api :PUT, '/users/:id', 'Update users'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

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

  # DELETE /users/1
  api :DELETE, '/users/:id', 'Destroy user account'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def destroy
    @user.destroy
    head :ok
  end

  api :POST, '/users/login', 'Login user'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def login
    credentials = JSON.parse request.body.string
    email = credentials['email']
    password = credentials['password']
    user = User.find_by_email email
    if user && user.authenticate(password)
      cookies[:token] = AuthToken.issue_token({'user_id': user.id})
      render json:
                 {
                     'id': user.id,
                     'name': user.name,
                     'surname': user.surname,
                     'email': user.email,
                     "role": user.role
                 },
             status: :ok
    else
      head :unauthorized
    end
  end

  def logout
    cookies.delete :token
  end

  api :POST, '/users/logout', 'Logout user'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  api :PUT, '/users/change_password', 'Change password'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

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

  api :PUT, '/users/change_email', 'Change email'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

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
