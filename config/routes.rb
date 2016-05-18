Rails.application.routes.draw do

  get 'pron/index'

  get 'teaches/search'
  resources :courses
  get 'courses/:id/student', to: 'courses#student',  as: 'course_student'
  get 'courses/:id/test', to: 'courses#test',  as: 'course_test'

  resources :tests

  resources :teaches, only: [:index, :create, :destroy]
  resources :enrolls, only: [:create, :destroy]
  resources :test_for_courses, only: [:create, :destroy]
  resources :do_tests, only: [:index, :create, :edit, :update]

  devise_for :users, :controllers => { :registrations => "registrations" }

  root 'static_pages#home'
  get 'static_pages/help'


end
