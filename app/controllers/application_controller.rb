class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  private
    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def redirect_back_or_default(default)
      redirect_to session[:return_to] || default
      session[:return_to] = nil
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end
end
