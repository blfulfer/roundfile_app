class RenameOrdernum < ActiveRecord::Migration
  def self.up
  rename_column :resumesections, :orderNum, :ordernum
	drop_table :resumesection
  end

  def self.down
  end
end
