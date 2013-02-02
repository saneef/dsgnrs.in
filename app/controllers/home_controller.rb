class HomeController < ApplicationController
  def index
    @place = ['Bangalore', 'Mumbai', 'New Delhi'].sample
  end
end
