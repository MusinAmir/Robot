Rails.application.routes.draw do
  require 'sidekiq/web'
  mount Sidekiq::Web => "/sidekiq"
  root 'accounts#index'
  resources :accounts do 
  	  resources :ad_units
		member do
   		 	get 'synhronize'
  		end

  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
