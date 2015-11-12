class DeleteControllerFromConfigValue < ActiveRecord::Migration
  def change
    remove_column :config_values, :controller, :string
  end
end
