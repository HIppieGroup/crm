Rails.application.routes.draw do
  root "user#profile" 
  get 'profile', to: :show, controller: 'user'
  
  devise_for :users
  resources :user, shallow: true do
  	resources :tascs
  end

  resources :groups, shallow: true do
    post 'add_group' ,to: :add_group, controller: 'groups' 
    post 'dell_user' ,to: :dell_user, controller: 'groups' 
    post 'add_chef' ,to: :add_chef, controller: 'groups' 
    resources :tascs
  	resources :user 
  end



end
