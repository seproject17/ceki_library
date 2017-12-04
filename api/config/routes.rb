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
  resources :users do
  	post '/users/login', action: :login
  	post '/users/logout', action: :logout
  	put '/users/change_password', action: :change_password
  	put '/users/change_email', action: :change_email
  end
end
