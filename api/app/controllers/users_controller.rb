class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :update, :destroy]

  before_action :verify_token, except: [:login]
  before_action :current_user, except: [:login]
  before_action :set_user, only: [:show, :update, :destroy, :change_email, :change_password]
  before_action :allowed_only_admin, except: [:index, :show, :login, :show, :change_password, :change_email]
  before_action :allow_only_own_account, only: [:update, :destroy, :change_email, :change_password]

  # GET /users
  api :GET, '/users', 'Find all users'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def index
    @users = User.all.select :id, :name, :surname, :email
    render json: @users
  end

  # GET /users/1
  api :GET, '/user/:id', 'Find user by id'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def show
    render json: @user
  end

  # POST /users
  api :POST, '/users', 'Sign up user'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def create
    @user = User.new(JSON.parse request.body.string)

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
    if @user.update!(updated_user)
      render json: @user, status: :ok
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
      render json: {'token': AuthToken.issue_token({'user_id': user.id})}, status: :ok
    else
      head :unauthorized
    end
  end

  api :POST, '/users/logout', 'Logout user'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  api :PUT, '/users/change_password', 'Change password'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def change_password
    password = JSON.parse(request.body)['password']
    @current_user.password = password
    @current_user.save!
    head :ok
  end

  api :PUT, '/users/change_email', 'Change email'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'

  def change_email
    email = JSON.parse(request.body)['email']
    if User.find_by_email email
      head :forbidden
    end
    @current_user.email = email
    @current_user.save!
    head :ok
  end

  private
  def set_user
    begin
      @user = User.find(params[:id])
    rescue
      render json: {'error': "User with specific id = #{params[:id]} not found"}, status: :not_found
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
