class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :store_return_to

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def facebook_user
    FbGraph::User.me session[:omniauth]["credentials"]["token"]
  end
  
  def base_url
    host = request.port.blank? ? request.host : request.host_with_port
    request.protocol + host
  end
  
  def require_user
    unless current_user
      if request.xhr?
        render :js => "window.location = '/needsToLogin'"
      else
        redirect_to "/needsToLogin"
      end
      return false
    end
  end
  
  def store_return_to
    if request.get? and !request.url.include? 'auth' and !request.url.include? 'needsToLogin'
      session[:return_to] = request.url
    end
  end
  
  def flash_and_redirect(flashMessage, redirect_url)
    flash[:notice] = flashMessage
    redirect_to redirect_url
  end 
  
end
