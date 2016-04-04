class RegistrationsController < Devise::RegistrationsController


  def settings
    @user = current_user
    if @user
      render :settings
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  private

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
end
