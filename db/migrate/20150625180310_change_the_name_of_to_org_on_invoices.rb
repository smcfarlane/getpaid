class ChangeTheNameOfToOrgOnInvoices < ActiveRecord::Migration
  def change
    rename_column :invoices, :to_org, :to_org_id
  end
end
