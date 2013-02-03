class User < ActiveRecord::Base
  attr_accessible :name, :nickname, :provider, :uid, :email, :company, :company_url, :url

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.name = auth["info"]["name"]
      user.nickname = auth["info"]["nickname"]

      user.email = nil
      user.url = nil
      user.company = nil
      user.company_url = nil

      user.is_admin = false
      user.is_approved = nil
    end
  end
end
