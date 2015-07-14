class User < ActiveRecord::Base
  attr_accessible :name, :email, :company, :company_url, :url
  belongs_to :city

  strip_attributes

  validates :city_virtual,
            :on => :update,
            :length => {
              :minimum => 3,
              :message => "Thats too short for a city name"
            }
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
              :with => /\A(?i)\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?]))\z/,
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
              :with => /\A(?i)\b((?:https?:\/\/|www\d{0,3}[.]|[a-z0-9.\-]+[.][a-z]{2,4}\/)(?:[^\s()<>]+|\(([^\s()<>]+|(\([^\s()<>]+\)))*\))+(?:\(([^\s()<>]+|(\([^\s()<>]+\)))*\)|[^\s`!()\[\]{};:'".,<>?]))\z/,
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

  def self.all_waiting
    self.where(is_approved: nil).order('created_at DESC')
  end

  def self.all_approved
    self.where(is_approved: true).order('created_at DESC')
  end

  def self.all_rejected
    self.where(is_approved: false).order('created_at DESC')
  end

  def city_virtual
    @city_virtual
  end

  def city_virtual=(str)
    @city_virtual = str.strip
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

  def absolute_url
    if self.url.blank?
      ""
    elsif self.url[/^http:\/\//] || self.url[/^https:\/\//]
      self.url
    else
      'http://' + self.url
    end
  end

  def company_absolute_url
    if self.company_url.blank?
      ""
    elsif self.company_url[/^http:\/\//] || self.company_url[/^https:\/\//]
      self.company_url
    else
      'http://' + self.company_url
    end
  end
end
