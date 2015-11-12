class RenameLayoutToScopeInConfigValue < ActiveRecord::Migration
  def change
    remove_column :config_values, :layout
    add_column :config_values, :scope, :string
  end
end
