class CreateEmails < ActiveRecord::Migration
  def change
    create_table :emails do |t|
      t.string :email, null: false
      t.integer :emailable_id
      t.string :emailable_type

      t.timestamps null: false
    end
  end
end
