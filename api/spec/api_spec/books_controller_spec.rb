require 'rails_helper'

RSpec.describe BooksController, type: :controller do

  fixtures :users
  fixtures :books

  before :each do
    @controller = UsersController.new
    params = {email: 'admin@mail.ru', password: 'admin'}.to_json
    post :login, body: params, as: :json
    @controller = BooksController.new
  end
  describe 'POST books#create' do
    it 'create new book' do
      new_book = {
          'isbn': '1234567894',
          'title': 'Unknown Pleasures',
          'author': 'Ray Stevenson',
          'publisher': 'Factory Records',
          'year': '1962-01-01',
          'annotations': 'She is your little voodoo dolly',
          'available_count': 5,
          'max_count': 10
      }.to_json
      post :create, body: new_book, as: :json
      expect(response).to be_success
      returned_book = JSON.parse response.body
      book_id = returned_book['id']
      book = Book.find book_id
      expect(book).not_to be_nil
      expect(book.isbn).to eq '1234567894'
      expect(book.title).to eq 'Unknown Pleasures'
      expect(book.author).to eq 'Ray Stevenson'
      expect(book.publisher).to eq 'Factory Records'
      expect(book.year).to eq Date.new(1962, 1, 1)
      expect(book.annotations).to eq 'She is your little voodoo dolly'
      expect(book.available_count).to eq 5
      expect(book.max_count).to eq 10
    end
  end

  describe 'PUT books#update' do
    it 'update book' do
      updated_book = {
          'isbn': '1234567894',
          'title': 'Unknown Pleasures',
          'author': 'Ray Stevenson',
          'publisher': 'Factory Records',
          'year': '1962-01-01',
          'annotations': 'She is your little voodoo dolly',
          'available_count': 5,
          'max_count': 10
      }.to_json
      params = {
          'id': books(:book_one).id
      }
      put :update, params: params, body: updated_book, as: :json
      expect(response).to be_success
      book = Book.find books(:book_one).id
      expect(book.isbn).to eq '1234567894'
      expect(book.title).to eq 'Unknown Pleasures'
      expect(book.author).to eq 'Ray Stevenson'
      expect(book.publisher).to eq 'Factory Records'
      expect(book.year).to eq Date.new(1962, 1, 1)
      expect(book.annotations).to eq 'She is your little voodoo dolly'
      expect(book.available_count).to eq 5
      expect(book.max_count).to eq 10
    end
  end

  describe 'DELETE books#destroy' do
    it 'delete book' do
      delete :destroy, params: {'id': books(:book_one).id}
      expect(Book.exists? 1).to be_falsey
    end
  end

  describe 'GET books#index' do
    it 'find all books' do
      get :index
      books = JSON.parse response.body
      expect(books.length).to eq 3
    end
  end

  describe 'GET books#show' do
    it 'find book with specific id' do
      book = books(:book_one)
      expect(book.isbn).to eq '1234567890'
      expect(book.title).to eq 'A Clockwork Orange'
      expect(book.author).to eq 'Anthony Burgess'
      expect(book.publisher).to eq 'Steven King Nightmare'
      expect(book.year).to eq Date.new(1977, 1, 1)
      expect(book.annotations).to eq 'White on white translucent black capes'
      expect(book.available_count).to eq 19
      expect(book.max_count).to eq 19
    end
  end
end