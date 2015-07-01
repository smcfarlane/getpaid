class AddActiveAndPaidToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :paid, :boolean, default: false
    add_column :invoices, :active, :boolean, default: true
  end
end
