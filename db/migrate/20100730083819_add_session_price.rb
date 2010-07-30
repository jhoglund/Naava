class AddSessionPrice < ActiveRecord::Migration
  def self.up
    add_column :courses, :session_price, :integer
  end

  def self.down
    remove_column :courses, :session_price
  end
end
