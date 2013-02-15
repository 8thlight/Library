Library::Application.routes.draw do

  root :to => 'books#index'

  get '/books/new' => 'books#new', as: 'new_book'

  post '/books' => 'books#create'

  get '/books/:isbn' => 'books#show', as: 'book'

  get '/books/:isbn/edit' => 'books#edit', as: 'edit_book'

  put '/books/:isbn' => 'books#update', as: 'update_book'

end

