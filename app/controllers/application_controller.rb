class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :ensure_login
  helper_method :logged_in?

  # unless Rails.application.config.consider_all_requests_local
    # rescue_from Exception, :with => :render_error
    rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
    rescue_from ActionController::RoutingError, :with => :render_not_found
  # end
  #called by last route matching unmatched routes.  Raises RoutingError which will be rescued from in the same way as other exceptions.
   def raise_not_found!
     respond_to do |f|
       f.html { redirect_to authorities_url }
       # f.html { redirect_to authorities_url, notice: 'No such a record' }
       # f.html{ render :template => "errors/404", :status => 404 }
       f.js{ render :partial => "errors/ajax_404", :status => 404 }
     # raise ActionController::RoutingError.new("No route matches #{params[:unmatched_route]}")
   end
   end

   #render 500 error
   def render_error(e)
     respond_to do |f|
       f.html{ render :template => "assets/500", :status => 500 }
       f.js{ render :partial => "assets/ajax_500", :status => 500 }
     end
   end

   #render 404 error
   def render_not_found(e)
     respond_to do |f|
       f.html { redirect_to authorities_url }
       # f.html { redirect_to authorities_url, notice: 'No such a record' }
       # f.html{ render :template => "errors/404", :status => 404 }
       f.js{ render :partial => "errors/ajax_404", :status => 404 }
     end
   end

  protected
  def ensure_login
    redirect_to editor_path unless session[:editor_id]
  end

  def logged_in?
    session[:editor_id]
  end

  def remote_ip
    if request.remote_ip == '::1'
      # Hard coded remote address
      '82.204.202.86'
    else
      request.remote_ip
    end
  end

end
