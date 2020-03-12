Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#index"

  # profile management
  get '/myprofile', to: 'profiles#show', as: 'myprofile'
  patch '/myprofile', to: 'profiles#update'
  get '/myprofile/public', to: 'profiles#public', as: 'myprofile_public'
  get '/myprofile/edit', to: 'profiles#edit', as: 'edit_myprofile'
  delete '/myprofile/delete_picture', to: 'profiles#destroy_picture', as: 'delete_myprofile_picture'
  get '/userprofile/:id', to: 'profiles#public', as: 'userprofile_public'

  # listing management
  get '/listings/my', to: 'listings#my', as: 'my_listings'
  resources :listings, except: [:index]
  delete '/listings/:id/image/:index', to: 'listings#destroy_image', as: 'delete_listing_image'

  # lease management
  get '/lease_requests/sent', to: 'lease_requests#sent', as: 'sent_lease_requests'
  get '/lease_requests/received', to: 'lease_requests#received', as: 'received_lease_requests'
  resources :lease_requests, except: [:new, :index]
  get '/lease_requests/new/:listing_id', to: 'lease_requests#new', as: 'new_lease_request'
  patch '/lease_requests/:id/accept', to: 'lease_requests#accept', as: 'accept_lease_request'
  patch '/lease_requests/:id/reject', to: 'lease_requests#reject', as: 'reject_lease_request'

  # when page not found
  get "/:path", to: "home#not_found"
end
