Rails.application.routes.draw do
  scope module: :public do
    root to: "homes#top"

    resource :users, only: [:show, :edit, :update] do
      get "confirm" => "users#confirm"
      patch "withdrawal" => "users#withdrawal"
    end

    resources :topics, only: [:index, :create, :show, :edit, :update, :destroy] do
      collection do
        get "tag_search" => "topics#tag_search"
        get "word_search" => "topics#word_search"
      end
    end

    resources :tags, only: [:index] do
      collection do
        get "word_search" => "tags#word_search" #実装しないのであれば削除する
      end
    end

    resources :acquaintances, only: [:index, :create, :edit, :update, :destroy] do
      member do
        get "stocks" => "acquaintances#stocks_index"
      end
    end

    resources :stocks, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  namespace :admin do
    get '/' => "homes#top"

    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get "topics" => "users#topic_index"
      end
    end

    resources :topics, only: [:index, :show, :edit, :update, :destroy] do
      collection do
        get "tag_search" => "topics#tag_search"
        get "word_search" => "topics#word_search"
      end
    end

    resources :tags, only: [:index] do
      collection do
        get "word_search" => "tags#word_search" #実装しないのであれば削除する
      end
    end

    resources :comments, only: [:destroy]
  end

  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
