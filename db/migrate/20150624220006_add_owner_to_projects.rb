class AddOwnerToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :owner, :integer
  end
end
