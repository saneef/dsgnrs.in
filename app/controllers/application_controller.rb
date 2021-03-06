class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user,
                :cities_with_users,
                :site_tagline,
                :site_title,
                :body_classnames

  private

    def cities_with_users
      ids_of_cities_with_approved_users = User.all_approved.pluck(:city_id).uniq

      @cities_with_users = City
        .where('id' => ids_of_cities_with_approved_users)
        .order('lower(name)')
    end

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def site_title
      "Designers in India"
    end

    def site_tagline
      "The Missing Directory of Product Designers in India"
    end

    def redirect_back_or_default(default)
      redirect_to session[:return_to] || default
      session[:return_to] = nil
    end

    def not_found
      raise ActionController::RoutingError.new('Not Found')
    end

    def permission_denied
      render :file => "public/404.html", :status => 403, :layout => false
    end

    def body_classnames=(classnames)
      @body_classnames = classnames
    end

    def body_classnames
      @body_classnames
    end
end
