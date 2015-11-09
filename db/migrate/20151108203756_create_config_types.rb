class CreateConfigTypes < ActiveRecord::Migration
  def change
    create_table :config_types do |t|
      t.string :name
      t.string :klass

      t.timestamps null: false
    end
    add_index :config_types, :name, unique: true
  end
end
