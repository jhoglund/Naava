class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
      t.belongs_to :booker, :polymorphic => true
      t.belongs_to :participant
      t.string :token
      t.timestamps
    end
  end

  def self.down
    drop_table :bookings
  end
end
