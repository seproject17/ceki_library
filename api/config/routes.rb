Rails.application.routes.draw do
  resources :reviews
  resources :books

  post 'books/:id/borrow' => 'books#borrow_book'
  post 'books/:id/return' => 'books#return_book'
  post 'users/login' => 'users#login'
  post 'users/logout' => 'users#logout'
  put 'users/change_password' => 'users#change_password'
  put 'users/change_email' => 'users#change_email'
  get 'users/current' => 'users#show_current'
  resources :users
end
