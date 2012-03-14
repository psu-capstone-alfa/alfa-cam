# Base controller providing global helper methods
#
class ApplicationController < ActionController::Base
  protect_from_forgery
  helper :all
  helper_method :current_user_session, :current_user
  before_filter :require_user
  check_authorization

  layout 'application'

  rescue_from CanCan::AccessDenied do |exception|
    exception.default_message = "You do not have authorization for this page"
    render 'misc/un_auth', layout: 'application'
  end

  def redirect_to(*args)
    flash.keep
    if params[:_redirect_endpoint]
      args[0] = params[:_redirect_endpoint]
    end
    super(*args)
  end

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.record
    end

    def require_user
      unless current_user
        store_location
        flash[:alert] = "You must be logged in to access this page"
        redirect_to login_path
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:alert] = "You must be logged out to access this page"
        redirect_to profile_path
        return false
      end
    end

    def store_location
      session[:return_to] = request.url
    end

    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end
end
