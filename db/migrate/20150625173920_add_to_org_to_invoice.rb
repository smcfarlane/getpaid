class AddToOrgToInvoice < ActiveRecord::Migration
  def change
    add_column :invoices, :to_org, :integer
  end
end
