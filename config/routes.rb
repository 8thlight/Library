Library::Application.routes.draw do

  root :to => 'books#index'

  get '/books/new' => 'books#new', as: 'new_book'
  post '/books' => 'books#create'

  get '/books/:isbn' => 'books#show', as: 'book'

  get '/books/:isbn/edit' => 'books#edit', as: 'edit_book'

  put '/books/:isbn' => 'books#update'


  get 'book/:isbn/check_out' => 'books#check_out', as: 'check_out'
  post 'book/:isbn/check_out' => 'books#check_out'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'

  match '/signout' => 'sessions#destroy', :as => :signout
  match '/signin' => 'sessions#new', :as => :signin

end

