class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :email, :phone_number, presence: true
  validates :registration_number, uniqueness: true 
  validates :registration_number, length: { is: 14 }
  validates :phone_number, length: { is: 10 }
  validates :email, { format: /\A\S+@.+\.\S+\z/ }

  def formatted_registration_number
    CNPJ.new(self.registration_number).formatted
  end

  def formatted_phone_number
    ddd = self.phone_number[0..1]
    "(#{ddd}) #{self.phone_number[2..5]}-#{self.phone_number[6..9]}"
  end

end
