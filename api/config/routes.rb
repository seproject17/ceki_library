Rails.application.routes.draw do
  resources :book_items
  apipie
  resources :reviews
  resources :e_books
  resources :books do
    get '/books/:id/items', action: :find_items
    get '/books/:id/items/free', action: :find_free_items
    get '/users/:id/books/read', action: :find_read_books
    get '/users/:id/books/borrowed', action: :find_borrowed_books
  end
  resources :users
  post 'login' => 'users#login'
  put 'change_password' => 'users#change_password'
  put 'change_email' => 'users#change_email'
end
