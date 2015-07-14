class CurateController < ApplicationController
  #GET /:status
  def index
    if current_user && current_user.is_admin?
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
    else
      permission_denied
    end
  end
end
