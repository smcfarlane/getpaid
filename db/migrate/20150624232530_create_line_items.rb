class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :invoice
      t.string :item
      t.text :description
      t.decimal :amount

      t.timestamps null: false
    end
  end
end
