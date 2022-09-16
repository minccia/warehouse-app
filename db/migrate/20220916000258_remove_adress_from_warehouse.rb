class RemoveAdressFromWarehouse < ActiveRecord::Migration[7.0]
  def change
    remove_column :warehouses, :adress
  end
end
