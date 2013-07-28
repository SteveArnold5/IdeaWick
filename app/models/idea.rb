class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :site
  has_many :votes, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  validates_presence_of :ideaText
  
  def voted_by_user(user)
    votes.each do |vote|
      return true if vote.user == user
    end
    return false
  end
  
  def new_comment()
    Comment.new(:idea => self)
  end
  
end
