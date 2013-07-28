class AddSubsiteIdToTopic < ActiveRecord::Migration
  def change
    add_column :topics, :subsite_id, :integer
  end
end
