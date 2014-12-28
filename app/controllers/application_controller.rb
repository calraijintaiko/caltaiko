=begin rdoc
The ApplicationController is the parent of all the other application's controllers.

It mainly deals with authentification and security.
=end
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_location

  def store_location
    if (!request.fullpath.match("/users") &&
        request.fullpath != "/login" &&
        request.fullpath != "/logout" &&
        request.fullpath != "/settings" &&
        request.fullpath != "/register" &&
        (request.format == "text/html" || request.content_type == "text/html") &&
        !request.xhr?) # don't store ajax calls
      session[:last_request_time] = Time.now.utc.to_i
      session[:previous_url] = request.fullpath
    end
  end

  def after_sign_in_path_for(resource)
    if (session[:previous_url] && session[:last_request_time] &&
        (Time.now.utc.to_i - session[:last_request_time] < 21600))
      session[:previous_url]
    else
      root_path
    end
  end

  protected

  # Used by Devise, this method defines what fields show up for respective actions
  # (+sign_up+, +sign_in+, +account_update+).
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
