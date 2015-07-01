class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.references :organization, index: true, foreign_key: true
      t.references :account, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
