class Warehouse < ApplicationRecord
  validates :name, :description, :code, :area, :city, :zip_code, :address, presence: true
  validates :name, :code, uniqueness: true
  validates :code, length: { is: 3 }
  validates :zip_code, length: { is: 8}

  def corrected_zip_code
    self.zip_code.gsub(/\d{3}$/, '') << '-' << self.zip_code.gsub(/^\d{5}/, '') 
  end
end
