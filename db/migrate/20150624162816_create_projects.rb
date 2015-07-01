class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :identifier
      t.date :start_date
      t.date :end_date

      t.timestamps null: false
    end

    create_join_table :projects, :organizations, table_name: :project_orgs do |t|
      t.string :role
    end
  end
end
