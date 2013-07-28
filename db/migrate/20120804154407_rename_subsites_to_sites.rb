class RenameSubsitesToSites < ActiveRecord::Migration
  def change
      rename_table :subsites, :sites
  end
end
