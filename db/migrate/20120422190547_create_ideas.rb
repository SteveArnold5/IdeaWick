class CreateIdeas < ActiveRecord::Migration
  def change
    create_table :ideas do |t|
      t.text :ideaText
      t.references :user
      t.references :topic
      t.timestamps
    end
  end
end
