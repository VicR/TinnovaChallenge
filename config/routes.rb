Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'auth/login', to: 'authentication#login'

  scope 'api' do
    scope 'v1' do
      resources :beers
      post 'beers/get_all', to: 'beers#get_all'
      post 'beers/:id/favorite', to: 'beers#set_favorite'
      get 'beer/favorite', to: 'beers#get_favorite'
    end
  end
end
