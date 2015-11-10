class CreateConfigValues < ActiveRecord::Migration
  def change
    create_table :config_values do |t|
      t.references :config_type, foreign_key: true
      t.text :value
      t.string :layout
      t.string :controller
      t.string :context

      t.timestamps null: false
    end
  end
end
