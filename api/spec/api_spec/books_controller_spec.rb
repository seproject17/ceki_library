require 'rails_helper'

RESOURCES_ROOT = File.join(File.expand_path('..', File.dirname(__FILE__)), 'resources')
PUBLIC_ROOT = File.join(File.expand_path('..', File.expand_path('..', File.dirname(__FILE__))), 'public')
CONTENT_PATH1 = File.join(RESOURCES_ROOT, 'content1.pdf')
CONTENT_PATH2 = File.join(RESOURCES_ROOT, 'content2.pdf')

RSpec.describe BooksController, type: :controller do

  fixtures :users
  fixtures :books

  before :each do
    one = Book.find books(:one).id
    one.content = file2base64(CONTENT_PATH1)
    two = Book.find books(:two).id
    two.content = file2base64(CONTENT_PATH2)
    @controller = UsersController.new
    params = {email: 'admin@mail.ru', password: 'admin'}.to_json
    post :login, body: params, as: :json
    @controller = BooksController.new
  end


  describe 'Create book' do
    it 'should create a new book' do
      new_book = {
          'isbn': '1234567894',
          'title': 'Unknown Pleasures',
          'author': 'Ray Stevenson',
          'publisher': 'Factory Records',
          'year': '1962-01-01',
          'annotations': 'She is your little voodoo dolly',
          'available_count': 5,
          'max_count': 10,
          'content': file2base64(CONTENT_PATH1)
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
      expect(book.content.url).to eq "/uploads/book/content/#{book['id']}/content.pdf"
    end
  end

  describe 'Update book' do
    it 'should update a book' do
      updated_book = {
          'isbn': '1234567894',
          'title': 'Unknown Pleasures',
          'author': 'Ray Stevenson',
          'publisher': 'Factory Records',
          'year': '1962-01-01',
          'annotations': 'She is your little voodoo dolly',
          'available_count': 5,
          'max_count': 10,
          'content': file2base64(CONTENT_PATH1)
      }.to_json
      params = {
          'id': books(:one).id
      }
      put :update, params: params, body: updated_book, as: :json
      expect(response).to be_success
      book = Book.find books(:one).id
      expect(book.isbn).to eq '1234567894'
      expect(book.title).to eq 'Unknown Pleasures'
      expect(book.author).to eq 'Ray Stevenson'
      expect(book.publisher).to eq 'Factory Records'
      expect(book.year).to eq Date.new(1962, 1, 1)
      expect(book.annotations).to eq 'She is your little voodoo dolly'
      expect(book.available_count).to eq 5
      expect(book.max_count).to eq 10
      expect(book.content.url).to eq "/uploads/book/content/#{book['id']}/content.pdf"
    end
  end

  describe 'Delete book' do
    it 'should delete a book' do
      delete :destroy, params: {'id': books(:one).id}
      expect(Book.exists? books(:one).id).to be_falsey
    end
    it 'deleting book should be forbidden if user is not staff' do
      @controller = UsersController.new
      params = {email: 'visitor@mail.ru', password: 'visitor'}.to_json
      post :login, body: params, as: :json
      @controller = BooksController.new
      delete :destroy, params: {'id': books(:one).id}
      expect(response).to have_http_status :forbidden
      expect(Book.exists? books(:one).id).to be_truthy
    end
  end

  describe 'Find all books' do
    it 'should find all books' do
      get :index
      books = JSON.parse response.body
      expect(books.length).to eq 3
    end
  end

  describe 'Find book by id' do
    it 'should find book with specific id' do
      get :show, params: {'id': books(:one)}
      book = JSON.parse response.body
      expect(book['isbn']).to eq '1234567890'
      expect(book['title']).to eq 'Title 1'
      expect(book['author']).to eq 'Author 1'
      expect(book['publisher']).to eq 'Publisher 1'
      expect(book['year']).to eq '1977-01-01'
      expect(book['annotations']).to eq 'Annotations 1'
      expect(book['available_count']).to eq 19
      expect(book['max_count']).to eq 19
    end

    it 'expect 404 if book not found' do
      ids = [
          books(:one).id, books(:two).id, books(:three).id
      ]
      get :show, params: {'id': gen_id(*ids)}
      expect(response).to have_http_status :not_found
    end
  end

  describe 'Borrow book' do
    it 'should borrow a book successfully' do
      post :borrow, params: {'id': books(:one).id}
      expect(response).to have_http_status :ok
      p JSON.parse response.body
    end
    it 'borrowing should be forbidden if not free instances of book' do
      book = Book.find(books(:one).id)
      book.available_count = 0
      book.save
      post :borrow, params: {'id': book.id}
      expect(response).to have_http_status :forbidden
    end
  end
end