# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]
  respond_to :json

  def create
    super do |resource|
      if resource.errors.empty?
        render json: { message: 'Signed in successfully.', user: resource }, status: :ok
      else
        render json: { message: 'Sign in failed.', errors: resource.errors.full_messages }, status: :unauthorized
      end
    end
  end


  private

  

  def respond_with(resource, _opts = {})
    render json: resource
  end

  def respond_to_on_destroy
    head :no_content
  end

  # def respond_with(resource, _opts = {})
  #   if resource.errors.empty?
  #     render json: { message: 'Signed in successfully.' }, status: :ok
  #   else
  #     render json: { message: 'Sign in failed.', errors: resource.errors.full_messages }, status: :unauthorized
  #   end
  # end
  
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  end
end
