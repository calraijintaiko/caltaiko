Rails.application.routes.draw do
  get 'errors/file_not_found'

  get 'errors/unprocessable'

  get 'errors/internal_server_error'

  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'pages#front'

  scope controller: :pages do
    get 'about' => :about, as: :about
    get 'about/collegiate-taiko' => :collegiate_taiko, as: :collegiate_taiko
    get 'contact' => :contact, as: :contact
    get 'media' => :media, as: :media
    get 'showcase' => :showcase, as: :showcase
  end

  resources :members do
    collection do
      get 'current'
      get 'alumni'
      get 'gen' => :all_gens
      get 'gen/:id' => :gen
      get 'database'
    end
  end

  resources :performances do
    collection do
      get 'upcoming'
      get 'past'
    end
  end

  resources :articles, path: 'news'
  resources :videos

  if Rails.env.production?
    devise_for :users, controllers: { registrations: 'registrations' }
  else
    devise_for :users
  end

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'settings', to: 'devise/registrations#edit'
    get 'logout', to: 'devise/sessions#destroy', as: :logout
    get 'register', to: 'devise/registrations#new'
  end

  # Error handling
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
