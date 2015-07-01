class AddColumnsToOrganizations < ActiveRecord::Migration
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    add_column :organizations, :details, :hstore
  end
end
