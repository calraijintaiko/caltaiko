Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'front_page#main'

  get 'about' => 'pages#about'
  get 'contact' => 'pages#contact'
  get 'performances/upcoming' => 'performances#upcoming'
  get 'performances/past' => 'performances#past'
  get 'performances/show/:id' => 'performances#show'
  get 'members' => 'members#index'
  get 'members/current' => 'members#current'
  get 'members/alumni' => 'members#alumni'
  get 'members/gen' => 'members#all_gens'
  get 'members/gen/:id' => 'members#gen'
  get 'news' => 'articles#index'
  get 'media' => 'pages#media'

  resources :members
  resources :videos
  resources :performances
  resources :performance_videos
  resources :articles

  if Rails.env.production?
    devise_for :users, controllers: { registrations: "registrations" }
  else
    devise_for :users
  end

  devise_scope :user do
    get "login", :to => "devise/sessions#new"
    get "settings", :to => "devise/registrations#edit"
    get "logout",   :to => "devise/sessions#destroy"
    # MUST BE REMOVED BEFORE DISTRIBUTING; there should be no way to register new users
    # Included purely for testing reasons
    get "register", to: "devise/registrations#new"
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
