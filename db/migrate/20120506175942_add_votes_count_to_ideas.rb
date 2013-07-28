class AddVotesCountToIdeas < ActiveRecord::Migration 
  def self.up
    add_column :ideas, :votes_count, :integer, :default => 0

    Idea.reset_column_information
    Idea.find(:all).each do |i|
      Idea.update_counters i.id, :votes_count => i.votes.length
    end
  end

  def self.down
    remove_column :ideas, :votes_count
  end
end

