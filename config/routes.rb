Rails.application.routes.draw do
  root to: 'api_searches#index'
  resources :api_searches
end
