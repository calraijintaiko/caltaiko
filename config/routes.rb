Rails.application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'pages#front'

  get 'about', to: 'pages#about', as: :about
  get 'contact', to: 'pages#contact', as: :contact
  get 'news', to: 'articles#index', as: :news
  get 'media', to: 'pages#media', as: :media

  get 'performances/upcoming', to: 'performances#upcoming',
                               as: :upcoming_performances
  get 'performances/past', to: 'performances#past', as: :past_performances

  get 'members' => 'members#index'
  get 'members/current', to: 'members#current', as: :current_members
  get 'members/alumni', to: 'members#alumni', as: :alumni_members
  get 'members/gen', to: 'members#all_gens', as: :members_all_gens
  get 'members/gen/:id', to: 'members#gen', as: :members_gen
  get 'members/database', to: 'members#database', as: :members_database

  resources :members
  resources :videos
  resources :performances
  resources :articles

  if Rails.env.production?
    devise_for :users, controllers: { registrations: 'registrations' }
  else
    devise_for :users
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'settings', to: 'devise/registrations#edit'
    get 'logout',   to: 'devise/sessions#destroy', as: :logout
    get 'register', to: 'devise/registrations#new'
  end

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
