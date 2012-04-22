class RenameOrder < ActiveRecord::Migration
  	def self.up
    rename_column :resumesections, :order, :ordernum
	drop_table :resumesection
  end

  def self.down

  end
end
