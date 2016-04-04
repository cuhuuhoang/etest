Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  devise_scope :user do
    # root :to => 'devise/registrations#new'
    get '/settings' => 'devise/registrations#settings', as: :settings
  end

  root 'static_pages#home'

  get 'static_pages/help'


end
