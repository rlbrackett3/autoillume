class ApplicationController < ActionController::Base
  include ControllerAuthentication # /lib/controller_authentication.rb
  protect_from_forgery
  # force_ssl

  before_filter :load_static_pages, :load_external_links

  private

  def load_static_pages
    @pages = Page.rank(:page_order)
  end

  def load_external_links
    @external_links = ExternalLink.rank(:link_order)
  end

  # def admin_logged_in?
  #   current_admin
  # end

  # def admin_login_required
  #   unless admin_logged_in?
  #     store_target_location
  #     redirect_to login_url, :alert => "You must first log in or sign up before accessing this page."
  #   end
  # end

  # def redirect_to_target_or_default(default, *args)
  #   redirect_to(session[:return_to] || default, *args)
  #   session[:return_to] = nil
  # end


  # def current_admin
  #   @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  # end
  # # helper_method :current_admin

  # def store_target_location
  #   session[:return_to] = request.url
  # end

  # helper_method :current_admin, :admin_logged_in?, :redirect_to_target_or_default

end
