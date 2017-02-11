Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :slugs, :only => [:show, :new, :create]
  get  '/:slug' => 'slugs#show'
  post '/' => 'slugs#create'
  root to: "slugs#index"

  get '/stats/:slug' => 'stats#show'

end
