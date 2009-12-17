class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.string :to_name
      t.string :to_email
      t.string :to_phone
      t.string :to_address
      t.string :from_name
      t.string :from_email
      t.string :from_phone
      t.string :from_address
      t.text :message
      t.string :token
      t.string :type
      t.belongs_to :coupon_type
      t.datetime :valid_from
      t.datetime :valid_to
      
      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
