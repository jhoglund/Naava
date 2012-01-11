class AddCoursePrice < ActiveRecord::Migration
  def self.up
    add_column :course_types, :price, :integer
  end

  def self.down
    remove_column :course_types, :price
  end
end