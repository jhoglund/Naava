class CreateCouponTypes < ActiveRecord::Migration
  def self.up
    create_table :coupon_types do |t|
      t.string :name
      t.text :description
      t.integer :value
      t.datetime :valid_from
      t.datetime :valid_to
      t.string :type
      t.timestamps
    end
  end

  def self.down
    drop_table :coupon_types
  end
end
