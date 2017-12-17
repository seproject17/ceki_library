require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  # Admin
  describe 'Admin operations on users account' do
    before :each do
      params = {email: 'admin@mail.ru', password: 'admin'}.to_json
      post :login, body: params, format: :json
      @request.headers['Authorization'] = 'JWT ' + JSON.parse(@response.body)['token']
    end
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
        get :show, params: {:id => 1}
        expect(response).to be_success
        user = JSON.parse @response.body
        expect(user).not_to be_nil
      end
      it 'find no one user with specific invalid id = 8' do
        get :show, params: {:id => 8}
        expect(response).to have_http_status :not_found
      end
    end
    describe 'POST users#create' do
      it 'create new admin account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'admin'
        }.to_json
        post :create, body: user, format: :json
        expect(response).to have_http_status :created
        user = JSON.parse @response.body
        expect(user).not_to be_nil
        expect(user['name']).to eq 'Robert'
        expect(user['surname']).to eq 'Smith'
        expect(user['email']).to eq 'cured@mail.ru'
        expect(user['role']).to eq 'admin'
      end
      it 'create new visitor account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor'
        }.to_json
        post :create, body: user, format: :json
        expect(response).to have_http_status :created
        user = JSON.parse @response.body
        expect(user).not_to be_nil
        expect(user['name']).to eq 'Robert'
        expect(user['surname']).to eq 'Smith'
        expect(user['email']).to eq 'cured@mail.ru'
        expect(user['role']).to eq 'visitor'
      end
      it 'create new librarian account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'librarian'
        }.to_json
        post :create, body: user, format: :json
        expect(response).to have_http_status :created
        user = JSON.parse @response.body
        expect(user).not_to be_nil
        expect(user['name']).to eq 'Robert'
        expect(user['surname']).to eq 'Smith'
        expect(user['email']).to eq 'cured@mail.ru'
        expect(user['role']).to eq 'librarian'
      end
    end
    describe 'PUT users#update' do
      it 'update user account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor'
        }.to_json
        put :update, params: {:id => 1}, body: user, format: :json
        user = User.find 1
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
      end
    end
    describe 'DELETE users#destroy' do
      it 'delete user account' do
        delete :destroy, params: {:id => 1}
        expect{User.find (1)}.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
  # Visitors
  describe 'Visitor operations on users account' do
    before :each do
      params = {email: 'visitor@mail.ru', password: 'visitor'}.to_json
      post :login, body: params, format: :json
      @request.headers['Authorization'] = 'JWT ' + JSON.parse(@response.body)['token']
    end
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
        get :show, params: {:id => 1}
        expect(response).to be_success
        user = JSON.parse @response.body
        expect(user).not_to be_nil
      end
      it 'find no one user with specific invalid id = 8' do
        get :show, params: {:id => 8}
        expect(response).to have_http_status :not_found
      end
    end
    describe 'POST users#create' do
      it 'disallow creating new admin account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday'
        }.to_json
        post :create, body: user, format: :json
        expect(response).to have_http_status :forbidden
      end
    end
    xdescribe 'PUT users#update' do
      it 'update own user account' do
        user = {
            name: 'Robert',
            surname: 'Smith',
            email: 'cured@mail.ru',
            password: 'friday',
            role: 'visitor'
        }.to_json
        put :update, params: {:id => 2}, body: user, format: :json
        user = User.find 2
        expect(user.name).to eq 'Robert'
        expect(user.surname).to eq 'Smith'
      end
    end
    describe 'DELETE users#destroy' do
      it 'disallow deleting user account' do
        delete :destroy, params: {:id => 1}
        expect(response).to have_http_status :forbidden
      end
    end
  end
end
