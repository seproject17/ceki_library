require 'rails_helper'

RESOURCES_ROOT = File.join(File.expand_path('..', File.dirname(__FILE__)), 'resources')
PUBLIC_ROOT = File.join(File.expand_path('..', File.expand_path('..', File.dirname(__FILE__))), 'public')
AVATAR_PATH = File.join(RESOURCES_ROOT, 'avatar.jpg')
BASE64_IMG_REGEX = /data:(image\/gif|image\/jpeg|image\/png);base64,([a-zA-Z0-9+\/]+)=/i

IMG2MIME = {
    :gif => 'image/gif',
    :jpeg => 'image/jpeg',
    :png => 'image/png',
    :jpg => 'image/jpg'
}

def file2base64(file_path)
  img_type = file_path.split('.').last.to_sym
  f = File.open(file_path, 'r')
  base64_content = Base64.strict_encode64(f.read)
  "data:#{IMG2MIME[img_type]};base64,#{base64_content}="
end


RSpec.describe UsersController, type: :controller do

  fixtures :users

  # Admin
  describe 'Admin operations on users account' do

    # Authorization
    before :each do
      params = {email: 'admin@mail.ru', password: 'admin'}.to_json
      post :login, body: params, as: :json
    end

    after :each do
      post :logout
    end

    # Find all users
    describe 'GET users#index' do
      it 'find all users' do
        get :index
        expect(response).to be_success
        users = JSON.parse @response.body
        expect(users.length).to eq 3
      end
    end
    describe 'GET users#show' do
      it 'find one user with specific id = 1' do
        get :show, params: {:id => users(:admin).id}
        expect(response).to be_success
        user = JSON.parse @response.body
        expect(user['name']).to eq users(:admin).name
        expect(user['surname']).to eq users(:admin).surname
        expect(user['email']).to eq users(:admin).email
        expect(user['role']).to eq users(:admin).role
      end
      it 'find no one user with specific invalid id = 8' do
        get :show, params: {:id => 8}
        expect(response).to have_http_status :not_found
      end
    end

    # Create new user
    describe 'POST users#create' do
      it 'create new admin account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'admin',
            avatar: file2base64(AVATAR_PATH)
        }.to_json
        post :create, body: user, format: :json
        expect(response).to have_http_status :created
        user = JSON.parse @response.body
        expect(user).not_to be_nil
        expect(user['name']).to eq 'Robert'
        expect(user['surname']).to eq 'Smith'
        expect(user['email']).to eq 'cured@mail.ru'
        expect(user['role']).to eq 'admin'
        expect(user['avatar']).should_not be_nil
        expect(user['avatar']['url']).to eq "/uploads/user/avatar/#{user['id']}/avatar.jpg"

        user = User.find user['id']
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
        expect(user.email).to eq 'cured@mail.ru'
        expect(user.role).to eq 'admin'
        expect(user.avatar).should_not be_nil
        expect(user.avatar.url).to eq "/uploads/user/avatar/#{user['id']}/avatar.jpg"
      end
      it 'create new visitor account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor',
            avatar: file2base64(AVATAR_PATH)
        }.to_json
        post :create, body: user, format: :json
        expect(response).to have_http_status :created
        user = JSON.parse @response.body
        expect(user).not_to be_nil
        expect(user['name']).to eq 'Robert'
        expect(user['surname']).to eq 'Smith'
        expect(user['email']).to eq 'cured@mail.ru'
        expect(user['role']).to eq 'visitor'
        expect(user['avatar']).should_not be_nil
        expect(user['avatar']['url']).to eq "/uploads/user/avatar/#{user['id']}/avatar.jpg"

        user = User.find user['id']
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
        expect(user.email).to eq 'cured@mail.ru'
        expect(user.role).to eq 'visitor'
        expect(user.avatar).should_not be_nil
        expect(user.avatar.url).to eq "/uploads/user/avatar/#{user['id']}/avatar.jpg"
      end
      it 'create new librarian account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'librarian',
            avatar: file2base64(AVATAR_PATH)
        }.to_json
        post :create, body: user, format: :json
        expect(response).to have_http_status :created
        user = JSON.parse @response.body
        expect(user).not_to be_nil
        expect(user['name']).to eq 'Robert'
        expect(user['surname']).to eq 'Smith'
        expect(user['email']).to eq 'cured@mail.ru'
        expect(user['role']).to eq 'librarian'
        expect(user['avatar']).should_not be_nil
        expect(user['avatar']['url']).to eq "/uploads/user/avatar/#{user['id']}/avatar.jpg"

        user = User.find user['id']
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
        expect(user.email).to eq 'cured@mail.ru'
        expect(user.role).to eq 'librarian'
        expect(user.avatar).should_not be_nil
        expect(user.avatar.url).to eq "/uploads/user/avatar/#{user['id']}/avatar.jpg"
      end
    end

    # Update user
    describe 'PUT users#update' do
      it 'update own user account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor'
        }.to_json
        put :update, params: {:id => users(:admin).id}, body: user, format: :json
        user = User.find users(:admin).id
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
        expect(user.email).to eq 'cured@mail.ru'
        expect(user.role).to eq 'visitor'
      end

      it 'update not own user account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'librarian'
        }.to_json
        put :update, params: {:id => users(:librarian).id}, body: user, format: :json
        user = User.find users(:librarian).id
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
        expect(user.email).to eq 'cured@mail.ru'
        expect(user.role).to eq 'librarian'
      end
    end

    # Delete user
    describe 'DELETE users#destroy' do
      it 'delete user account' do
        delete :destroy, params: {:id => users(:admin).id}
        expect {User.find (users(:admin).id)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    describe 'DELETE users#delete_avatar' do
      it 'delete users avatar' do
        delete :delete_avatar
        expect(response).to be_success
        user = User.find users(:admin).id
        expect(user.avatar.url).to be_nil
      end
    end


    describe 'PUT users#change_email' do
      it 'change own email' do
        params = {password: 'admin', email: 'new_admin@mail.ru'}.to_json
        put :change_email, body: params, as: :json
        expect(response).to be_success
        user = User.find_by_email 'new_admin@mail.ru'
        expect(user.name).to eq users(:admin).name
        expect(user.surname).to eq users(:admin).surname
        expect(user.role).to eq users(:admin).role
        expect(User.exists? :email => 'admin@mail.ru').to be_falsey
      end
    end

    describe 'PUT users#change_password' do
      it 'change own password' do
        params = {old_password: 'admin', new_password: 'new_admin'}.to_json
        put :change_password, body: params, as: :json
        expect(response).to be_success
        user = User.find_by_email 'admin@mail.ru'
        expect(user.name).to eq users(:admin).name
        expect(user.surname).to eq users(:admin).surname
        expect(user.role).to eq users(:admin).role
        expect(user.authenticate('new_admin')).to be_truthy
      end
    end
  end

  # Visitors
  describe 'Visitor operations on users account' do
    before :each do
      params = {email: 'visitor@mail.ru', password: 'visitor'}.to_json
      post :login, body: params, as: :json
    end
    after :each do
      post :logout
    end
    describe 'POST users#create' do
      it 'disallow creating new admin account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday'
        }.to_json
        post :create, body: user, as: :json
        expect(response).to have_http_status :forbidden
      end
    end
    describe 'PUT users#update' do
      it 'update own user account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor'
        }.to_json
        put :update, params: {:id => users(:visitor).id}, body: user, as: :json
        expect(response).to be_success
        user = User.find users(:visitor).id
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
        expect(user.email).to eq 'cured@mail.ru'
        expect(user.role).to eq 'visitor'
      end
      it 'disallow to update not own user account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor'
        }.to_json
        put :update, params: {:id => users(:admin).id}, body: user, as: :json
        expect(response).to have_http_status :forbidden
      end
    end
    describe 'DELETE users#destroy' do
      it 'disallow to delete user account' do
        delete :destroy, params: {:id => users(:visitor).id}
        expect(response).to have_http_status :forbidden
      end
    end

    describe 'PUT users#change_email' do
      it 'change own email' do
        params = {password: 'visitor', email: 'new_visitor@mail.ru'}.to_json
        put :change_email, body: params, as: :json
        expect(response).to be_success
        user = User.find_by_email 'new_visitor@mail.ru'
        expect(user.name).to eq users(:visitor).name
        expect(user.surname).to eq users(:visitor).surname
        expect(user.role).to eq users(:visitor).role
        expect(User.exists? :email => 'visitor@mail.ru').to be_falsey
      end
    end

    describe 'PUT users#change_password' do
      it 'change own password' do
        params = {old_password: 'visitor', new_password: 'new_visitor'}.to_json
        put :change_password, body: params, as: :json
        expect(response).to be_success
        user = User.find_by_email 'visitor@mail.ru'
        expect(user.name).to eq users(:visitor).name
        expect(user.surname).to eq users(:visitor).surname
        expect(user.role).to eq users(:visitor).role
        expect(user.authenticate('new_visitor')).to be_truthy
      end
    end
  end

  # Librarians
  describe 'Librarian operations on users account' do
    before :each do
      params = {email: 'librarian@mail.ru', password: 'librarian'}.to_json
      post :login, body: params, as: :json
    end
    after :each do
      post :logout
    end
    describe 'POST users#create' do
      it 'disallow creating new admin account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday'
        }.to_json
        post :create, body: user, as: :json
        expect(response).to have_http_status :forbidden
      end
    end
    describe 'PUT users#update' do
      it 'update own user account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor'
        }.to_json
        put :update, params: {:id => users(:librarian).id}, body: user, as: :json
        expect(response).to be_success
        user = User.find users(:librarian).id
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
        expect(user.email).to eq 'cured@mail.ru'
        expect(user.role).to eq 'visitor'
      end
      it 'disallow to update not own user account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor'
        }.to_json
        put :update, params: {:id => users(:admin).id}, body: user, as: :json
        expect(response).to have_http_status :forbidden
      end
    end
    describe 'DELETE users#destroy' do
      it 'disallow deleting user account' do
        delete :destroy, params: {:id => users(:librarian).id}
        expect(response).to have_http_status :forbidden
      end
    end

    describe 'PUT users#change_email' do
      it 'change own email' do
        params = {password: 'librarian', email: 'new_librarian@mail.ru'}.to_json
        put :change_email, body: params, as: :json
        expect(response).to be_success
        user = User.find_by_email 'new_librarian@mail.ru'
        expect(user.name).to eq users(:librarian).name
        expect(user.surname).to eq users(:librarian).surname
        expect(user.role).to eq users(:librarian).role
        expect(User.exists? :email => 'librarian@mail.ru').to be_falsey
      end
    end

    describe 'PUT users#change_password' do
      it 'change own password' do
        params = {old_password: 'librarian', new_password: 'new_librarian'}.to_json
        put :change_password, body: params, as: :json
        expect(response).to be_success
        user = User.find_by_email 'librarian@mail.ru'
        expect(user.name).to eq users(:librarian).name
        expect(user.surname).to eq users(:librarian).surname
        expect(user.role).to eq users(:librarian).role
        expect(user.authenticate('new_librarian')).to be_truthy
      end
    end
  end
end
