RSpec.describe BorrowingsController, type: :controller do
  fixtures :users
  fixtures :books
  before :each do
    @controller = UsersController.new
    params = {email: 'admin@mail.ru', password: 'admin'}.to_json
    post :login, body: params, as: :json
    @controller = BorrowingsController.new
  end
  it 'Find all borrowings' do

  end
end