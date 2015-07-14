class CurateController < ApplicationController
  #GET /:status
  def index
    logger.debug "Listing users from: #{params[:status]}" if params[:status]
    case params[:status]
    when 'waiting'
      @users = User.all_waiting
    when 'rejected'
      @users = User.all_rejected
    when 'approved'
      redirect_to root_url
    else
      not_found
    end
  end
end
