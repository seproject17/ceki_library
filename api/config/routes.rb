Rails.application.routes.draw do
  resources :reviews
  resources :e_books
  resources :books
  resources :users do
  	post '/login', action: :login
  	post '/logout', action: :logout
  	put '/change_password', action: :change_password
  	put '/change_email', action: :change_email
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
