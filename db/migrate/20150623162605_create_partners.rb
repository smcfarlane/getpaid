class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.references :organization
      t.integer :vendor_id
      t.integer :client_id

      t.timestamps null: false
    end
  end
end
