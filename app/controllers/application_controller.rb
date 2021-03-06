class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource
  before_filter :authenticate_user! , if: -> { controller_name != "pron" }

    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:full_name, :email, :password, :type,
                                                              :password_confirmation, :remember_me) }
      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password, :remember_me) }
      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:full_name, :avatar, :skype, :facebook, :phone,
                               :address, :dob, :password, :password_confirmation, :current_password) }
    end

    def layout_by_resource
      if devise_controller? and !user_signed_in?
        "devise_layout"
      elsif controller_name == "pron"
        "mobile_layout"
      else
        "application"
      end
    end

end
