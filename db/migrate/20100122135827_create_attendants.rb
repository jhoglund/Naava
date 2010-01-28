class CreateAttendants < ActiveRecord::Migration
  def self.up
    create_table :attendants do |t|
      t.belongs_to :participant
      t.belongs_to :session
      t.integer :status
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :attendants
  end
end
