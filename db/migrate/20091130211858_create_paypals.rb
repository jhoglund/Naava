class CreatePaypals < ActiveRecord::Migration
  def self.up
    create_table :paypal_reciepts do |t|
      t.string :transaction_id
      t.float :gross
      t.float :fee
      t.string :currency
      t.string :item_id
      t.string :item_type
      t.string :item_name
      t.string :status
      t.string :type
      t.string :custom
      t.string :pending_reason
      t.string :reason_code
      t.text :memo
      t.string :payment_type
      t.float :exchange_rate
      t.timestamp :received_at

      t.timestamps
    end
  end

  def self.down
    drop_table :paypal_reciepts
  end
end
