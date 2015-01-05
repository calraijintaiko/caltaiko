# The ApplicationController is the parent of all the other application's
# controllers.
#
# It mainly deals with authentification and security.
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :store_location

  # rubocop:disable Metrics/AbcSize, Style/GuardClause
  def store_location
    path = request.fullpath
    users = ['/login', '/logout', '/settings', '/register']
    html = request.format == 'text/html' || request.content_type == 'text/html'
    if !path.match('/users') && html && !request.xhr? && !users.include?(path)
      session[:last_request_time] = Time.now.utc.to_i
      session[:previous_url] = path
    end
  end
  # rubocop:enable Metrics/AbcSize, Style/GuardClause

  def after_sign_in_path_for(_resource)
    prev_url = session[:previous_url]
    last_request_time = session[:last_request_time]
    if prev_url && last_request_time &&
       (Time.now.utc.to_i - last_request_time < 21_600)
      prev_url
    else
      root_path
    end
  end

  protected

  # Used by Devise, this method defines what fields show up for
  # respective actions (+sign_up+, +sign_in+, +account_update+).
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:username, :email, :password, :password_confirmation,
               :remember_me)
    end
    devise_parameter_sanitizer.for(:sign_in) do |u|
      u.permit(:login, :username, :email, :password, :remember_me)
    end
    devise_parameter_sanitizer.for(:account_update) do |u|
      u.permit(:username, :email, :password, :password_confirmation,
               :current_password)
    end
  end
end
