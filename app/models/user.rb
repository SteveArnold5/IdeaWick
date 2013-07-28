class User < ActiveRecord::Base
  has_many :sites, :dependent => :nullify, :order => 'created_at DESC'
  has_many :ideas, :dependent => :nullify, :order => 'created_at DESC'
  has_many :votes, :dependent => :nullify
  has_many :comments, :dependent => :destroy
  
  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      user.firstName = auth["info"]["first_name"]
      user.lastName = auth["info"]["last_name"] 
      user.fullName = auth["info"]["name"]
      user.email = auth["info"]["email"]
      user.imageUrl = auth["info"]["image"]
    end
  end
  
  def update_with_omniauth(auth)
      self.firstName = auth["info"]["first_name"]
      self.lastName = auth["info"]["last_name"] 
      self.fullName = auth["info"]["name"]
      self.email = auth["info"]["email"]
      self.imageUrl = auth["info"]["image"]
  end
  
  def imageUrl
    if read_attribute(:imageUrl).nil?
      return "/images/default_avatar.jpg"
    else
      return read_attribute(:imageUrl)
    end
  end
end
