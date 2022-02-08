Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # client id 3539186daab0474aa01799c819be83e2
  # client secret bfad5f22665d4fcda9d7d09a1f599515
  get '/health', to: 'health#health'

  resources :artists, only: [:create]
  scope :api, defaults: {format: :json} do
    get 'v1/artists', to: 'artists#index'
    get 'v1/artists/:id/albums', to: 'artists#albums'
    get 'v1/albums/:id/songs', to: 'albums#songs'
    get 'v1/genres/:genre_name/random_song', to: 'genres#random_song'
  end
end
