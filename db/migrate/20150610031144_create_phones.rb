class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone_number, null: false
      t.integer :callable_id
      t.string :callable_type

      t.timestamps null: false
    end
  end
end
