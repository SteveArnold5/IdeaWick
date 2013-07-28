class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :idea
  
  validates_presence_of :body
end
