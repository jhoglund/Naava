class CreateUserGiftCertificates < ActiveRecord::Migration
  def self.up
    create_table :user_gift_certificates do |t|
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
      t.belongs_to :gift_certificate

      t.timestamps
    end
  end

  def self.down
    drop_table :user_gift_certificates
  end
end
