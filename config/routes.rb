Rails.application.routes.draw do
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  resources :pictures do
    collection do
      post :confirm
    end
  end
  root to: 'users#new'
  resources :favorites, only: [:index, :create, :destroy]

  mount LetterOpenerWeb::Engine, at: "/letter_opener"
end