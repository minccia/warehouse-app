class Supplier < ApplicationRecord
  has_many :product_models
  validates :corporate_name, :brand_name, :registration_number, :email, :phone_number, presence: true
  validates :registration_number, uniqueness: true 
  validates :registration_number, length: { is: 14 }
  validates :phone_number, length: { is: 10 }
  validates :email, { format: /\A\S+@.+\.\S+\z/ }

  def formatted_registration_number
    CNPJ.new(registration_number).formatted
  end

  def formatted_phone_number
    ddd = phone_number[0..1]
    "(#{ddd}) #{phone_number[2..5]}-#{phone_number[6..9]}"
  end

  def full_description
    "#{brand_name} - #{corporate_name} | #{formatted_registration_number}"
  end
end
