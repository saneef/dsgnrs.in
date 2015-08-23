class CitiesController < ApplicationController
  #GET /:city
  def index
    @city = City.where(:slug => params[:city]).first

    if @city
      logger.debug "Listings from: #{@city.name}"

      @users = @city.users.all_approved

      if @users.size > 0
        logger.debug "#{@users.size} approved designers in #{@city.name}"
      else
        not_found
      end

    else
      not_found
    end
  end
end
