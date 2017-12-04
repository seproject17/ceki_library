require 'test_helper'

class BookOperationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book_operation = book_operations(:one)
  end

  test "should get index" do
    get book_operations_url, as: :json
    assert_response :success
  end

  test "should create book_operation" do
    assert_difference('BookOperation.count') do
      post book_operations_url, params: { book_operation: { op_date: @book_operation.op_date } }, as: :json
    end

    assert_response 201
  end

  test "should show book_operation" do
    get book_operation_url(@book_operation), as: :json
    assert_response :success
  end

  test "should update book_operation" do
    patch book_operation_url(@book_operation), params: { book_operation: { op_date: @book_operation.op_date } }, as: :json
    assert_response 200
  end

  test "should destroy book_operation" do
    assert_difference('BookOperation.count', -1) do
      delete book_operation_url(@book_operation), as: :json
    end

    assert_response 204
  end
end
