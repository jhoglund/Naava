class CreateCashes < ActiveRecord::Migration
  def self.up
    create_table :cashes do |t|
      t.integer :gross

      t.timestamps
    end
  end

  def self.down
    drop_table :cashes
  end
end
