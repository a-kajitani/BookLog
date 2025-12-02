Rails.application.routes.draw do
  get "sections/new"
  get "sections/create"
  get "sections/edit"
  get "sections/update"
  get "sections/destroy"
  # get "users/index"
  # get "users/show"
  # get "users/destroy"
  # devise_for :users
  # get "static_pages/home"
  # get "static_pages/help"
  # resources :books
  # root 'static_pages#home'
  # devise_for :users, controllers: {
  #   registrations: 'users/registrations'
  # }
  # resources :users, only: [:index, :show, :destroy]
  root 'static_pages#home'

  get "static_pages/home"
  get "static_pages/help"

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: [:index, :show, :destroy]
  
  resources :books do
    resources :sections, only: [:show, :new, :create, :edit, :update, :destroy] do
      resources :impressions, only: [:new, :create, :edit, :update, :destroy] do     
        collection do
          post :preview
        end
      end
    end
  end


  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index" 
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
