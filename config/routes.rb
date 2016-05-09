Rails.application.routes.draw do
  get 'enroll/create'

  get 'enroll/destroy'

  resources :teaches, only: [:index, :create, :destroy]
  get 'teaches/search'
  resources :courses
  get 'courses/:id/student', to: 'courses#student',  as: 'course_student'

  resources :enrolls, only: [:create, :destroy]

  devise_for :users, :controllers => { :registrations => "registrations" }
  # devise_scope :user do
  #   # root :to => 'devise/registrations#new'
  #   get '/settings' => 'registrations#settings', as: :settings
  # end

  root 'static_pages#home'

  get 'static_pages/help'


end
