class DeviseTokenAuthCreateAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :provider, :string, null: false
    add_column :accounts, :uid, :string, null: false, default: ''
    add_column :accounts, :confirmation_token, :string
    add_column :accounts, :confirmed_at, :datetime
    add_column :accounts, :confirmation_sent_at, :datetime
    add_column :accounts, :name, :string
    add_column :accounts, :tokens, :text
    add_column :accounts, :unconfirmed_email, :string

    add_index :accounts, [:uid, :provider],     :unique => true
    add_index :accounts, :confirmation_token,   :unique => true
  end
end
