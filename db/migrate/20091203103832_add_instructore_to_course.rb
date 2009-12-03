class AddInstructoreToCourse < ActiveRecord::Migration
  def self.up
    add_column :courses, :instructore_id, :integer
    remove_column :courses, :teatcher
  end

  def self.down
    remove_column :courses, :instructore_id
    add_column :courses, :teatcher, :string
  end
end
