class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    #This helper method is created so that we can access the current user inside
    #   the view
    helper_method :current_user

    def authorize
      redirect_to login_url, alert: "Not authorized" if current_user.nil?
    end
end
