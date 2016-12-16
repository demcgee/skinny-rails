Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :slug, :only => [:show, :new, :create]
  get  '/:id' => 'slug#show'
  post '/' => 'slug#create'
end
