Library::Application.routes.draw do

  devise_for :users

  root :to => 'books#index'

  get '/books/new' => 'books#new', as: 'new_book'
  post '/books' => 'books#create'

  get '/books/:isbn' => 'books#show', as: 'book'

  get '/books/:isbn/edit' => 'books#edit', as: 'edit_book'

  put '/books/:isbn' => 'books#update'


  get '/books/:isbn/check_out' => 'books#check_out', as: 'check_out'
  post '/books/:isbn/check_out' => 'books#check_out'

end

