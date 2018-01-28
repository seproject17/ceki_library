Rails.application.routes.draw do
  resources :reviews
  resources :books do
    get ':id/items', action: :find_items
    get ':id/items/free', action: :find_free_items
    get ':id/books/read', action: :find_read_books
    get ':id/books/borrowed', action: :find_borrowed_books
  end
  resources :users
  post 'users/login' => 'users#login'
  post 'users/logout' => 'users#logout'
  put 'users/change_password' => 'users#change_password'
  put 'users/change_email' => 'users#change_email'
end
