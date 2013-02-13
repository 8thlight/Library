Library::Application.routes.draw do

  root :to => 'books#index'

  get 'books' => 'books#index'

  get '/books/:isbn/edit' => 'books#edit'

  get '/books/new' => 'books#new'

  post '/books' => 'books#create'
end
