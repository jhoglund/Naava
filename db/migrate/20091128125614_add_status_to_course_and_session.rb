class AddStatusToCourseAndSession < ActiveRecord::Migration
  def self.up
    add_column :courses, :status, :integer, :default => 0
    add_column :sessions, :status, :integer, :default => 0
  end

  def self.down
    remove_column :courses
    remove_column :sessions
  end
end
