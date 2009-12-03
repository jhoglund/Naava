class CreateInstructors < ActiveRecord::Migration
  def self.up
    create_table :instructors do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :bio
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :instructors
  end
end
