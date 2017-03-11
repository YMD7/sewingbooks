Rails.application.routes.draw do

  # root
  root :to => 'library#index'
  resources :library

  # book
  resources :books

end
