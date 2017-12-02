require 'test_helper'

class EBooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @e_book = e_books(:one)
  end

  test "should get index" do
    get e_books_url, as: :json
    assert_response :success
  end

  test "should create e_book" do
    assert_difference('EBook.count') do
      post e_books_url, params: { e_book: { annotations: @e_book.annotations, author: @e_book.author, file_path: @e_book.file_path, publisher: @e_book.publisher, title: @e_book.title, year: @e_book.year } }, as: :json
    end

    assert_response 201
  end

  test "should show e_book" do
    get e_book_url(@e_book), as: :json
    assert_response :success
  end

  test "should update e_book" do
    patch e_book_url(@e_book), params: { e_book: { annotations: @e_book.annotations, author: @e_book.author, file_path: @e_book.file_path, publisher: @e_book.publisher, title: @e_book.title, year: @e_book.year } }, as: :json
    assert_response 200
  end

  test "should destroy e_book" do
    assert_difference('EBook.count', -1) do
      delete e_book_url(@e_book), as: :json
    end

    assert_response 204
  end
end
