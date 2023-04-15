Rails.application.routes.draw do
  #get 'users/show'
 # get 'users/edit'
  root to: "homes#top"
  devise_for :users
  #resources :books
  resources :books, only: [:create, :index, :show, :edit, :update, :destroy ] do
       resource :favorites, only: [:create, :destroy]
       resources :book_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update ]

  get 'home/about' => "homes#about"
  #get '/users' => "users#index"
  #get 'users/:id' => "users#show"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #devise_scope :user do
    #get '/users/sign_out' => 'devise/sessions#destroy'
  #end


end
