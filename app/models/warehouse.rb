class Warehouse < ApplicationRecord
  validates :name, :description, :code, :area, :city, :zip_code, :address, presence: true
  validates :name, :code, uniqueness: true
  validates :code, length: { maximum: 3 }
  validates :zip_code, format: { with: /^\d{5}-\d{3}$/, multiline: true }
end
