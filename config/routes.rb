Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
  }
  namespace :admins do
    resources :users, only: [:index, :edit, :update, :destroy]
    resources :posts, only: :index
    resources :genres, only: [:index, :edit, :create, :update, :destroy]
  end

  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
  }

  devise_scope :user do
    post "users/guest_sign_in" => "users/sessions#guest_sign_in"
  end

  scope module: :users do
    root "homes#top"
    get "inquiries" => "homes#inquiries", as: "inquiries"
    post "inquiries" => "homes#mail"
    get "done" => "homes#done", as: "done"
    get "users/mypage" => "users#show", as: "mypage"
    get "users/leave" => "users#leave"
    patch "users/withdraw" => "users#withdraw"
    get "users/information/edit" => "users#edit", as: "edit_information"
    patch "users/information" => "users#update"
    get "posts/ranks" => "posts#rank"
    get "posts/tags" => "posts#tag"
    resources :posts do
      resources :comments, only: [:edit, :create, :update, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    get "tag_search" => "posts#tag_search"
    get "search" => "posts#search"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
