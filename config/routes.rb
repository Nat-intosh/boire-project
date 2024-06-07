Rails.application.routes.draw do
  devise_for :users
  resources :random_words
  root 'pages#home'
  resources :cards, :random_words do
  collection do 
    post :import
  end
end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/next_random_card', to: 'cards#next_random_card', as: 'next_random_card'
  # Defines the root path route ("/")
  # root "posts#index"
end
