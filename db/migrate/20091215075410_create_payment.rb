class CreatePayment < ActiveRecord::Migration
  def self.up
    create_table :payments do |t|
      t.string :name
      t.string :email
      t.text :note
      t.text :meta
      t.string :token
      t.integer :item_id
      t.string :item_type
      t.integer :reciept_id
      t.string :reciept_type

      t.timestamps
    end
  end

  def self.down
    drop_table :payments
  end
end
