class ApplicationController < ActionController::Base
  # include ControllerAuthentication
  protect_from_forgery
  # force_ssl

  private

  def admin_logged_in?
    current_admin
  end

  def admin_login_required
    unless admin_logged_in?
      store_target_location
      redirect_to login_url, :alert => "You must first log in or sign up before accessing this page."
    end
  end

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end


  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end
  # helper_method :current_admin

  def store_target_location
    session[:return_to] = request.url
  end

  helper_method :current_admin, :admin_logged_in?, :redirect_to_target_or_default

end
