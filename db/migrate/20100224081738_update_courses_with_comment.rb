class UpdateCoursesWithComment < ActiveRecord::Migration
  def self.up
    add_column :courses, :comment, :text
  end

  def self.down
    remove_column :courses, :comment
  end
end
