Rails.application.routes.draw do
  resources :books

  post 'books/:id/borrow' => 'books#borrow'
  delete 'books/:id/cover' => 'books#delete_cover'
  delete 'books/:id/content' => 'books#delete_content'

  post 'borrowings/:id/accept' => 'borrowings#accept'
  post 'borrowings/:id/reject' => 'borrowings#reject'
  post 'borrowings/:id/borrow' => 'borrowings#borrow'
  post 'borrowings/:id/return' => 'borrowings#return'
  get 'borrowings/:id' => 'borrowings#show'
  get 'borrowings' => 'borrowings#index'
  get 'user/borrowings' => 'borrowings#find_by_user'

  get 'reviews/:id' => 'reviews#show'
  post 'books/:id/review' => 'reviews#create'
  put 'reviews/:id' => 'reviews#update'
  delete 'reviews/:id' => 'reviews#destroy'
  get 'books/:id/reviews' => 'reviews#find_by_book'
  get 'users/:id/reviews' => 'reviews#find_by_user'

  post 'users/login' => 'users#login'
  post 'users/logout' => 'users#logout'
  put 'users/change_password' => 'users#change_password'
  put 'users/change_email' => 'users#change_email'
  get 'users/current' => 'users#show_current'
  delete 'users/avatar' => 'users#delete_avatar'
  resources :users
end
