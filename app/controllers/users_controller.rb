class UsersController < ApplicationController
  def edit
    unless current_user
      session[:return_to] ||= request.fullpath
      redirect_to '/auth/twitter'
    end
  end
end
