require 'test_helper'

class BookItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_item = book_items(:one)
  end

  test "should get index" do
    get book_items_url, as: :json
    assert_response :success
  end

  test "should create book_item" do
    assert_difference('BookItem.count') do
      post book_items_url, params: { book_item: { loan_end_date: @book_item.loan_end_date, loan_start_date: @book_item.loan_start_date } }, as: :json
    end

    assert_response 201
  end

  test "should show book_item" do
    get book_item_url(@book_item), as: :json
    assert_response :success
  end

  test "should update book_item" do
    patch book_item_url(@book_item), params: { book_item: { loan_end_date: @book_item.loan_end_date, loan_start_date: @book_item.loan_start_date } }, as: :json
    assert_response 200
  end

  test "should destroy book_item" do
    assert_difference('BookItem.count', -1) do
      delete book_item_url(@book_item), as: :json
    end

    assert_response 204
  end
end
