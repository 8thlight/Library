Library::Application.routes.draw do

  resources :books

  root :to => 'books#index'

#  get 'books' => 'books#index'
#
#  get '/books/:id/edit' => 'books#edit'
#
#  get '/books/new' => 'books#new'
#
#  post '/books' => 'books#create'
end
