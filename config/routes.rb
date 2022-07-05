Rails.application.routes.draw do
  devise_for :users, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    root to: "homes#top"

    resources :users, only: [:show, :edit, :update] do
      member do
        get "confirm" => "users#confirm"
        patch "withdrawal" => "users#withdrawal"
      end
    end

    resources :topics, only: [:index, :create, :show, :edit, :update, :destroy] do
      collection do
        get "tag_search" => "topics#tag_search"
        get "word_search" => "topics#word_search"
      end
      resources :stocks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :tags, only: [:index] do
      collection do
        get "word_search" => "tags#word_search" #実装しないのであれば削除する
      end
    end

    resources :acquaintances, only: [:index, :create, :edit, :update, :destroy] do
      member do
        # get "stocks" => "acquaintances#stocks_index"
        # get ":user_id" => "acquaintances#stocks_index"
      end
    end
    # get "/acquaintances/:id/:user_id/stocks" => "acquaintances#stocks_index"

    resources :events, only: [:new, :create, :index, :update, :edit, :destroy]

  end

  namespace :admin do
    get '/' => "homes#top"

    resources :users, only: [:index, :show, :update] do
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
