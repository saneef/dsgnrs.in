class HomeController < ApplicationController
  def index
    city ||= params[:city]

    @place = city ? city : "India"

    unless ['bangalore', 'mumbai', 'new-delhi', 'india'].include?(@place.downcase)
      not_found
    end
  end
end
