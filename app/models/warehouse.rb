class Warehouse < ApplicationRecord
  validates :name, :description, :code, :area, :city, :zip_code, :address, presence: true
  validates :name, :code, uniqueness: true
  validates :code, length: { is: 3 }
  validates :zip_code, length: { is: 8}

  def formatted_zip_code
    "#{self.zip_code[0..4]}-#{self.zip_code[5..8]}"
  end
end
