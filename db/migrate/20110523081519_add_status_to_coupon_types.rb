class AddStatusToCouponTypes < ActiveRecord::Migration
  def self.up
    add_column :coupon_types, :status, :integer, :default => Status::ACTIVE
  end

  def self.down
    remove_column :coupon_types, :status
  end
end