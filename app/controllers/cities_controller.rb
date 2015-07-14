class CitiesController < ApplicationController
  #GET /:city
  def index
    @city = City.where(:slug => params[:city]).first
    logger.debug "Listings from: #{@city.name}" if @city

    if @city
      @users = @city.users.all_approved
    else
      not_found
    end
  end
end
