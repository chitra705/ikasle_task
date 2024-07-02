class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session
	before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit

  # Pundit: rescue from Pundit::NotAuthorizedError
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
