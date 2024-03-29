Rails.application.routes.draw do
  # devise関連
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions:      "public/sessions"
}
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
  sessions: "admin/sessions"
}
  # ゲストログイン
  devise_scope :user do
    post "users/guest_sign_in" => "public/sessions#guest_sign_in"
  end

  # user側のルーティング
  scope module: :public do
    root to: "homes#top"

    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get   "confirm"    => "users#confirm"
        patch "withdrawal" => "users#withdrawal"
      end
    end

    resources :topics, only: [:index, :create, :show, :update, :destroy] do
      collection do
        get "favorite_topics" => "topics#favorite_topics"
        get "tag_search"  => "topics#tag_search"
        get "word_search" => "topics#word_search"
      end
      resource  :stocks,   only: [:create, :update, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :tags, only: [:index]

    resources :acquaintances, only: [:index, :create, :show, :update, :destroy]

    resources :events, only: [:create, :index, :show, :update, :destroy] do
      member do
        patch "move_update" => "events#move_update"
      end
    end

    resources :notifications, only: [:index]
  end
  # admin側のルーティング
  namespace :admin do
    get "/" => "homes#top"

    resources :users, only: [:index, :show, :update] do
      member do
        get "topics" => "users#topic_index"
      end
    end

    resources :topics, only: [:show, :update, :destroy] do
      collection do
        get "tag_search"  => "topics#tag_search"
        get "word_search" => "topics#word_search"
      end
      resources :comments, only: [:destroy]
    end

    resources :tags, only: [:index, :destroy] do
      collection do
        get "destroy_index" => "tags#destroy_index"
      end
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
