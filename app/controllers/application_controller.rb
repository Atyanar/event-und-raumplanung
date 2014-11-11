class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      store_location_for(:user, request.env['PATH_INFO'])
      redirect_to new_user_session_path
    end
  end

  def after_sign_in_path_for(resource)
    stored_location_for(:user)
  end
end
