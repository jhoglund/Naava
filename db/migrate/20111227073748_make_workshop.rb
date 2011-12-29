class MakeWorkshop < ActiveRecord::Migration
  def self.up
    add_column :courses, :type, :string, :default => 'Course'
    add_column :sessions, :description, :text
    rename_column :sessions, :course_id, :course_type_id
    rename_table :courses, :course_types
  end

  def self.down
    rename_column :sessions, :course_type_id, :course_id
    remove_column :sessions, :description
    rename_table :course_types, :courses
    remove_column :courses, :type
  end
end