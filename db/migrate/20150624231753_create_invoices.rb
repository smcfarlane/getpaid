class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :project
      t.string :identifier
      t.date :date
      t.date :due_date
      t.integer :discount
      t.integer :discount_timeframe
      t.text :notes

      t.timestamps null: false
    end
  end
end
