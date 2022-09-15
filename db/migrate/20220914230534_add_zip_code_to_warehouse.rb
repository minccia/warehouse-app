class AddZipCodeToWarehouse < ActiveRecord::Migration[7.0]
  def change
    add_column :warehouses, :zip_code, :string
  end
end
