class CreateFrees < ActiveRecord::Migration
  def self.up
    create_table :frees do |t|
      t.belongs_to :reference, :polymorphic => true
      t.text :note
      t.timestamps
    end
  end

  def self.down
    drop_table :frees
  end
end
