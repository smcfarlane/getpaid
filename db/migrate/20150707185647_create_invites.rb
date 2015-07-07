class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.references :organization
      t.string :email
      t.integer :inviting_user
      t.string :identifier

      t.timestamps null: false
    end
  end
end
