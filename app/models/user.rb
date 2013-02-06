class User < ActiveRecord::Base
  attr_accessible :name, :email, :company, :company_url, :url

  validates :name,
            :length => {
              :minimum => 3,
              :message => "Thats too short for a name"
            }
  validates :email,
            :on => :update,
            :format => {
              :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/,
              :message => "That doesn't seem like a good email."
            }
  validates :url,
            :on => :update,
            :format => {
              :with => /\A(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))\z/,
              :message => "That doesn't seem like a good URL"
            }
  validates :company,
            :on => :update,
            :length => {
              :minimum => 3,
              :message => "Thats too short for a company name"
            }
  validates :company_url,
            :on => :update,
            :format => {
              :with => /\A(([\w-]+:\/\/?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|\/)))\z/,
              :message => "That doesn't seem like a good URL"
            }


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

  def image_url
    return "http://twitter.com/api/users/profile_image/#{self.nickname}?size=bigger"
  end

  def twitter_profile_url
    return "http://twitter.com/#{self.nickname}"
  end

  def is_admin?
    return self.is_admin
  end

  def is_approved?
    return self.is_approved
  end
end
