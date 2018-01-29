class ApplicationController < ActionController::Base
  require 'auth_token'

  protected

  def verify_token
    token = cookies[:token]
    head :unauthorized if token.nil? ||
        !AuthToken.valid?(token.split(' ').last)
  end

  def set_current_user
    token = cookies[:token]
    user_id = AuthToken.data(token.split(' ').last)['user_id']
    p "Current user with #{user_id}"
    @current_user = User.find user_id
    p "User was found"
  end

  def allowed_only_admin
    head :forbidden unless @current_user.admin?
  end

  def allowed_only_librarian
    head :forbidden unless @current_user.librarian?
  end

  def allowed_only_staff
    head :forbidden unless (@current_user.admin? && @current_user.librarian?)
  end
end
