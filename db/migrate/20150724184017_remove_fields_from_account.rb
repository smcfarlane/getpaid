class RemoveFieldsFromAccount < ActiveRecord::Migration
  def change
    remove_column :accounts, :provider
    remove_column :accounts, :uid
  end
end
