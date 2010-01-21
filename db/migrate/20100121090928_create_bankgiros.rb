class CreateBankgiros < ActiveRecord::Migration
  def self.up
    create_table :bankgiros do |t|
      t.integer :avinr
      t.integer :gross

      t.timestamps
    end
  end

  def self.down
    drop_table :bankgiros
  end
end
