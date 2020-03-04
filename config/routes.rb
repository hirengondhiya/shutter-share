Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  get '/myprofile', to: 'profiles#show', as: 'myprofile'
  patch '/myprofile', to: 'profiles#update'
  get '/myprofile/public', to: 'profiles#public', as: 'myprofile_public'
  get '/userprofile/:id', to: 'profiles#public', as: 'userprofile_public'
  get '/myprofile/edit', to: 'profiles#edit', as: 'edit_myprofile'
  delete '/myprofile/delete_picture', to: 'profiles#destroy_picture', as: 'delete_myprofile_picture'
end
