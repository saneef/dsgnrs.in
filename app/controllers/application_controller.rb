class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user,
                :cities_with_users,
                :site_tagline,
                :site_title,
                :body_classnames

  private

    def cities_with_users
      @cities_with_users = City.find(
        :all,
        :order => 'lower(name)'
      ).select do |city|
        city.users.find(
          :all,
          :conditions => ["is_approved = ?", true]
        ).size > 0
      end
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def site_title
      "Designers in India"
    end

    def site_tagline
      "The Missing Directory of Product Designers in India"
    end

    def redirect_back_or_default(default)
      redirect_to session[:return_to] || default
      session[:return_to] = nil
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def permission_denied
      render :file => "public/404.html", :status => 401, :layout => false
    end

    def body_classnames=(classnames)
      @body_classnames = classnames
    end

    def body_classnames
      @body_classnames
    end
end
