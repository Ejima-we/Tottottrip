Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
  }
  namespace :admins do
    resources :users, only: [:index, :edit, :update]
    resources :posts
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
  end
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }

  scope module: :users do
    root "homes#top"
    get "users/mypage" => "users#show", as: "mypage"
    get "users/edit" => "users#edit"
    get "users/leave" => "users#leave"
    patch "users/withdraw" => "users#withdraw"
    resources :posts do
      resources :comments, only: [:edit, :create, :update, :destroy]
      resource :favorites, only: [:index, :create, :destroy]
    end
    get "searches" => "searches#search"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
