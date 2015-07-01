class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_address, null: false
      t.string :street_address2, null: false, default: ''
      t.string :city, null: false
      t.string :state, null: false
      t.string :zip, null: false
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps null: false
    end
  end
end
