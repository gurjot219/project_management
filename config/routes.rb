Rails.application.routes.draw do
  root :to => "teams#index"

  devise_for :users
  post 'teams/send_invite'
  get 'teams/invite_sign_up'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :teams do
    resources :projects
  end
end
