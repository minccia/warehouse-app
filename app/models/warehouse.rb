class Warehouse < ApplicationRecord
  validates :name, :description, :code, :area, :zip_code, :address, presence: true
  #validates :name, :code, uniqueness: true
  #validates :zip_code, format: { with: /[[0-9]{5}-[0-9][3]]/ }
end
