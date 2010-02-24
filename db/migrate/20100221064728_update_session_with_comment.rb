class UpdateSessionWithComment < ActiveRecord::Migration
  def self.up
    change_column :sessions, :status, :integer, :default => 1
    add_column :sessions, :comment, :text
  end

  def self.down
    change_column :sessions, :status, :integer, :default => 0
    remove_column :sessions, :comment
  end
end
