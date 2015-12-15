Rails.application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'pages#front'

  get 'showcase', to: redirect('http://caltaiko-showcase-2015.eventbrite.com'),
    as: :showcase
  get 'videos', to: redirect('media/videos')

  # Moved contact form during redesign; shouldn't be used, but leaving
  # it in just in case
  scope controller: :messages do
    get 'contact/form' => :new, as: :contact_form
    post 'contact/form' => :create
  end

  scope controller: :pages do
    get 'about' => :about, as: :about
    get 'media' => :media, as: :media
    get 'media/videos' => :media_videos, as: :media_videos
    get 'media/galleries' => :media_galleries, as: :media_galleries
    get 'contact' => :contact, as: :contact
  end

  resources :members do
    collection do
      get 'current'
      get 'alumni'
      get 'gen' => :all_gens
      get 'gen/:gen' => :gen, constraints: { gen: /\d+/ }
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
  resources :videos, except: [:index, :show]

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
