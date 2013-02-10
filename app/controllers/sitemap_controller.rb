class SitemapController < ApplicationController
  # get /sitemap.xml
  def index

    @url_base = "#{request.scheme}://#{request.host_with_port}"
    @cities = cities_with_users
    respond_to do |format|
      format.xml
    end
  end
end
