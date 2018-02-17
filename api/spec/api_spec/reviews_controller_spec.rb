RSpec.describe ReviewsController, type: :controller do
  fixtures :users
  fixtures :books
  fixtures :reviews

  before :each do
    @controller = UsersController.new
    params = {email: 'admin@mail.ru', password: 'admin'}.to_json
    post :login, body: params, as: :json
    @controller = ReviewsController.new
  end

  it 'Find reviews by user' do
    get :find_by_user, params: {'id': users(:admin)}
    expect(response).to be_success
    reviews = JSON.parse response.body
    expect(reviews.length).to eq 2
  end

  it 'Find reviews by book' do
    get :find_by_book, params: {'id': books(:one)}
    expect(response).to be_success
    reviews = JSON.parse response.body
    expect(reviews.length).to eq 2
  end

  it 'Find review by id' do
    get :show, params: {'id': reviews(:one)}
    expect(response).to be_success
    review = JSON.parse response.body
    expect(review['comments']).to eq reviews(:one).comments
    expect(review['mark']).to eq reviews(:one).mark
    expect(review['book_id']).to eq reviews(:one).book.id
    expect(review['user_id']).to eq reviews(:one).user.id
  end

  it 'Create review' do
    @controller = UsersController.new
    params = {email: 'librarian@mail.ru', password: 'librarian'}.to_json
    post :login, body: params, as: :json
    @controller = ReviewsController.new
    review = {
        'mark': 10,
        'comments': 'Comment 3'
    }.to_json
    post :create, body: review, params: {'id': books(:three).id}, as: :json
    expect(response).to be_success
    review = JSON.parse response.body
    review = Review.find review['id']
    expect(review.mark).to eq 10
    expect(review.comments).to eq 'Comment 3'
    expect(review.user).to eq User.find users(:librarian).id
    expect(review.book).to eq Book.find books(:three).id
  end

  it 'Update review' do
    review = {
        'mark': 5,
        'comments': 'New Comment',
    }.to_json
    put :update, body: review, params: {'id': reviews(:one).id}
    expect(response).to be_success
    review = Review.find reviews(:one).id
    expect(review.mark).to eq 5
    expect(review.comments).to eq 'New Comment'
  end

  it 'Delete review' do
    delete :destroy, params: {'id': reviews(:one).id}
    expect(Review.exists? reviews(:one).id).to be_falsey
  end
end