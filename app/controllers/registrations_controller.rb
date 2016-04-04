class RegistrationsController < Devise::RegistrationsController

  params[:user].permit(:full_name, :avatar, :skype, :facebook, :phone, :address, :dob)

  def settings
    @user = current_user
    if @user
      render :settings
    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  private

  def after_inactive_sign_up_path_for(resource)
    new_user_session_path
  end
end
