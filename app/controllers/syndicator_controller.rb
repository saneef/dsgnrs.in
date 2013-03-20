class SyndicatorController < ApplicationController
  def feed
    @title = site_title
    expires_in 10.minutes, :public => true

    @users = User.find(
      :all,
      :conditions => { :is_approved => true },
      :order => 'created_at desc'
    )

    @updated = @users.first.updated_at unless @users.empty?

    respond_to do |format|
      format.atom { render :layout => false }
      format.any { redirect_to feed_path(:format => :atom), :status => :moved_permanently }
    end
  end
end
