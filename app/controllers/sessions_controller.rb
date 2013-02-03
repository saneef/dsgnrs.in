class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    redirect_to root_url unless auth

    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id

    redirect_back_or_default root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You've signed out."
  end

  def failure
    redirect_to root_url, :flash => { :error => "Oops. Couldn't Sign In with Twitter" }
  end
end
