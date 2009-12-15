class CreateGiftCertificates < ActiveRecord::Migration
  def self.up
    create_table :gift_certificates do |t|
      t.string :name
      t.text :description
      t.integer :value
      t.datetime :valid_from
      t.datetime :valid_to

      t.timestamps
    end
  end

  def self.down
    drop_table :gift_certificates
  end
end
