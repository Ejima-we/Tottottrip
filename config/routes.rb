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
    get "homes/about" => "homes#about", as: "about"
    get "users/mypage" => "users#show", as: "mypage"
    get "users/edit" => "users#edit"
    get "users/leave" => "users#leave"
    get "users/:id/favorite" => "users#favorite", as: "user_favorites"
    patch "users/withdraw" => "users#withdraw"
    get "posts/ranks" => "posts#rank"
    resources :posts do
      resources :comments, only: [:show, :create, :update, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    get "search" => "posts#search"
    get "searches" => "searches#search"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
