class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.text :summary
      t.integer :viewCount, :default => 0
      t.references :user
      t.timestamps
    end
  end
end
