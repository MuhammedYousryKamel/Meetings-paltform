require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users do 
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :meetings
    authenticate :user, lambda { |u| u.admin? } do
      mount Sidekiq::Web => '/sidekiq'
    end



  root to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
