class AddValidForPolymorphicToCoupon < ActiveRecord::Migration
  def self.up
    add_column :coupon_types, :valid_for, :string
    add_column :coupon_types, :times, :integer
  end

  def self.down
    remove_column :coupon_types, :times
    remove_column :coupon_types, :valid_for
  end
end
