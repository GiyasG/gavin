class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_login
  helper_method :logged_in?

  protected
  def ensure_login
    redirect_to editor_path unless session[:editor_id]
  end

  def logged_in?
    session[:editor_id]
  end
end
