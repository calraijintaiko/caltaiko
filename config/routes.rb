Rails.application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'pages#front'

  scope controller: :pages do
    get 'about' => :about, as: :about
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
end
