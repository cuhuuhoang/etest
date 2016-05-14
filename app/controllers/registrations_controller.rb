class RegistrationsController < Devise::RegistrationsController
  # before_filter :configure_permitted_parameters

  private

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
end
