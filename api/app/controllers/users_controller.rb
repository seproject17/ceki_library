class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  api :GET, '/users', 'Find all users'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def index
    @users = User.all
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
    @user = User.new(user_params)

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
    if @user.update(user_params)
      render json: @user
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
  end

  api :POST, '/users/login', 'Login user'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def login

  end

  api :POST, '/users/logout', 'Logout user'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def logout

  end

  api :PUT, '/users/change_password', 'Change password'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def change_password


  end

  api :PUT, '/users/change_email', 'Change email'
  error :code => 401, :desc => 'Unauthorized'
  error :code => 404, :desc => 'Not Found'
  def change_email


  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:name, :surname, :email, :password)
    end

  # swagger_controller :users, "Users"

  # swagger_api :index do
  #   summary "Fetches all Users"
  #   notes "This lists all the active users"
  #   param :query, :page, :integer, :optional, "Page number"
  #   param :path, :nested_id, :integer, :optional, "Team Id"
  #   response :unauthorized
  #   response :not_acceptable, "The request you made is not acceptable"
  #   response :requested_range_not_satisfiable
  # end

end
