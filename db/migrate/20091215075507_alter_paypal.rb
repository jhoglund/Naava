class AlterPaypal < ActiveRecord::Migration
  def self.up
    remove_column :paypal_reciepts,:item_id
    remove_column :paypal_reciepts, :item_type
    add_column :paypal_reciepts, :payment_reciept_id, :integer
  end

  def self.down
    add_column :paypal_reciepts,  :item_id, :integer
    add_column :paypal_reciepts, :item_type, :string
    remove_column :paypal_reciepts, :payment_reciept_id
  end
end
