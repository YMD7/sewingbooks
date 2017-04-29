Rails.application.routes.draw do

  # root
  root :to => 'library#index'
  resources :library
  match 'book', to: 'library#update_book', via: [:post]

  # book
  resources :books

  # devise
  devise_for :users,
    :controllers => { :invitations => 'users/invitations' }

end
