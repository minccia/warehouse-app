class AddDescriptionToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :description, :string
  end
end
