class RemoveSummaryFromTopics < ActiveRecord::Migration
  def up
    remove_column :topics, :summary
  end

  def down
    add_column :topics, :summary, :text
  end
end
