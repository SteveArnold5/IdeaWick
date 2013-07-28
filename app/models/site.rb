class Site < ActiveRecord::Base
  belongs_to :user
  has_many :ideas, :dependent => :nullify, :order => 'created_at DESC'
  
  validates :subdomain, :presence => true, :uniqueness => true, :format => { :with => /^[a-z\d]+(-[a-z\d]+)*$/i}
  validate :check_subdomain_for_reserved_words
  validates_presence_of :title
  
  def check_subdomain_for_reserved_words
    reserved =  ["www", "qa", "dev", "staging", "admin", "blog", "ftp", "mail", "support"]
    errors.add(:subdomain, "is not available") if reserved.include?(subdomain.downcase)
  end
end
