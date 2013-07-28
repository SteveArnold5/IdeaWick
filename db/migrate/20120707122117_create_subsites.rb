class CreateSubsites < ActiveRecord::Migration
  def change
    create_table :subsites do |t|
      t.string :subdomain

      t.timestamps
    end
  end
end
