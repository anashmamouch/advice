Rails.application.routes.draw do
# Authentication
  devise_for :users, :skip => [:sessions, :registrations]
    as :user do
       # session handling
      get '/login' => 'devise/sessions#new', :as => :new_user_session
      post '/login' => 'devise/sessions#create', :as => :user_session
      delete '/logout' => 'devise/sessions#destroy', :as => :destroy_user_session
      # joining md5(wakeupilot)
       get   '/4c69aabcef98b458943de1bb0ac59469' => 'devise/registrations#new',    as: :new_user_registration
       post  '/4c69aabcef98b458943de1bb0ac59469' => 'devise/registrations#create', as: :user_registration

       # settings & cancellation
      get '/cancel'   => 'devise/registrations#cancel', as: :cancel_user_registration
      get '/settings' => 'devise/registrations#edit',   as: :edit_user_registration
      put '/settings' => 'devise/registrations#update'

      # account deletion
      delete '' => 'devise/registrations#destroy'


    end

#Restrict access to sign_up page only for signed in users
#devise_for :users, :controllers => { :registrations => 'registrations'}
##
  #authenticate :user do
    #resources :logs, only: [ :create,:destroy]
  #end
    #resources :logs, only: [:index, :show]
##
namespace :api, defaults: {formats: 'json'} do
  namespace :v1 do
    resources :logs
  end
end

resources :logs
root "logs#index"
end
