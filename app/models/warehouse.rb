class Warehouse < ApplicationRecord
  validates :name, :description, :code, :area, :city, :zip_code, :address, presence: true
  validates :name, :code, uniqueness: true
  validates :code, length: { is: 3 }
  validates :zip_code, length: { is: 8}

  def formatted_zip_code
    "#{zip_code[0..4]}-#{zip_code[5..8]}"
  end

  def full_description
    "#{code} - #{name}"
  end
end
