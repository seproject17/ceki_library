Rails.application.routes.draw do
  resources :reviews
  resources :books

  post 'books/:id/borrow' => 'books#borrow'
  post 'books/:id/return' => 'books#return'
  post 'users/login' => 'users#login'
  post 'users/logout' => 'users#logout'
  put 'users/change_password' => 'users#change_password'
  put 'users/change_email' => 'users#change_email'
  get 'users/current' => 'users#show_current'
  resources :users
end
