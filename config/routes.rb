Rails.application.routes.draw do
     mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   root to: "articles#index"
   
   resources :articles do
     resources :comments, only: [:create, :destroy]
     resource :like, only: [:create, :destroy]
  end
  resources :accounts, only: [:show] do
    resources :follows, only: [:create]
    resources :unfollows, only: [:create]
  end
   resource :profile, only: [:show, :edit, :update]
   
   get "search" => "searches#search"
end
