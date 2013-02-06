Library::Application.routes.draw do

  resources :register_book, :only => [:new] do
    collection { get :_form }
  end

  #get "register_book/_form"
end
