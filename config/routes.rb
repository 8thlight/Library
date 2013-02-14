Library::Application.routes.draw do

  #resources :books

  root :to => 'books#index'

  get 'books' => 'books#index', as: 'books'

  get '/books/:isbn/edit' => 'books#edit', as: 'edit_book'

  get '/books/new' => 'books#new', as: 'new_book'

  get '/books/:isbn' => 'books#show', as: 'book'

  post '/books' => 'books#create'

end

