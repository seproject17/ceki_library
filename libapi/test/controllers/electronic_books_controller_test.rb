require 'test_helper'

class ElectronicBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @electronic_book = electronic_books(:one)
  end

  test "should get index" do
    get electronic_books_url, as: :json
    assert_response :success
  end

  test "should create electronic_book" do
    assert_difference('ElectronicBook.count') do
      post electronic_books_url, params: { electronic_book: { annotations: @electronic_book.annotations, author: @electronic_book.author, file_path: @electronic_book.file_path, publisher: @electronic_book.publisher, title: @electronic_book.title, year: @electronic_book.year } }, as: :json
    end

    assert_response 201
  end

  test "should show electronic_book" do
    get electronic_book_url(@electronic_book), as: :json
    assert_response :success
  end

  test "should update electronic_book" do
    patch electronic_book_url(@electronic_book), params: { electronic_book: { annotations: @electronic_book.annotations, author: @electronic_book.author, file_path: @electronic_book.file_path, publisher: @electronic_book.publisher, title: @electronic_book.title, year: @electronic_book.year } }, as: :json
    assert_response 200
  end

  test "should destroy electronic_book" do
    assert_difference('ElectronicBook.count', -1) do
      delete electronic_book_url(@electronic_book), as: :json
    end

    assert_response 204
  end
end
