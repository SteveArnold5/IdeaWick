class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :uid
      t.string :firstName
      t.string :lastName
      t.string :email
      t.string :imageUrl

      t.timestamps
    end
  end
end
