Rails.application.routes.draw do
  namespace :admin do
    get 'tags/index'
  end
  namespace :admin do
    get 'topics/index'
    get 'topics/show'
    get 'topics/edit'
  end
  namespace :admin do
    get 'users/index'
    get 'users/show'
    get 'users/edit'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'events/new'
    get 'events/index'
  end
  namespace :public do
    get 'acquaintances/index'
    get 'acquaintances/edit'
  end
  namespace :public do
    get 'tags/index'
  end
  namespace :public do
    get 'topic/index'
    get 'topic/edit'
  end
  namespace :public do
    get 'users/show'
    get 'users/edit'
  end
  namespace :public do
    get 'homes/top'
  end
  devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
