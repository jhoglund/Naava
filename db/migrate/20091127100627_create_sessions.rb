class CreateSessions < ActiveRecord::Migration
  def self.up
    create_table :sessions do |t|
      t.belongs_to :course
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end

  def self.down
    drop_table :sessions
  end
end
