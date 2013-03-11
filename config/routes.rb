Library::Application.routes.draw do

#  get "static/index"

  root :to => 'static#index'

  get 'user/return/:isbn' => 'return#create', as: 'return_book'
  post '/return' => 'return#create'

  get '/books/new' => 'books#new', as: 'new_book'
  post '/books' => 'books#create'

  get '/books/:isbn' => 'books#show', as: 'book'

  get '/mybooks' => 'books#mybooks', as: 'mybooks'

  get '/books/:isbn/edit' => 'books#edit', as: 'edit_book'

  put '/books/:isbn' => 'books#update'

  get 'book/:isbn/check_out' => 'checkouts#create', as: 'check_out'
  post '/checkouts' => 'checkouts#create'

  get '/checkouts' => 'checkouts#index'

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'

  match '/signout' => 'sessions#destroy', :as => :signout
  match '/signin' => 'sessions#new', :as => :signin
  match '/signin/8thlight' => 'sessions#open_id', :as => :signin_openid

  get 'book/:isbn/waiting_list' => 'waitinglists#create', as: 'wait_list'
  post '/waitinglist' => 'waitinglists#create'

end

