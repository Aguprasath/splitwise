Rails.application.routes.draw do


  devise_for :users
  resources :expenses, only: [:new, :create, :index] do
    collection do
      get 'expenses_with_friend/:friend_id', to: 'expenses#expenses_with_friend', as: 'expenses_with_friend'
      get 'expenses_due', to: 'expenses#expenses_due'
      get 'expenses_owe', to: 'expenses#expenses_owe'
    end

  end
  resources :settlements, only: [:new, :create]

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "expenses#index"
  get '/users', to: 'user#index'
end
