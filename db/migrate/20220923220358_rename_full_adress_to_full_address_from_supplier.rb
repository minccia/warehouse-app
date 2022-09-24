class RenameFullAdressToFullAddressFromSupplier < ActiveRecord::Migration[7.0]
  def change
    rename_column :suppliers, :full_adress, :full_address
  end
end
