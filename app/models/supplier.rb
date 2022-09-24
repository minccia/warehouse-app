class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :email, presence: true
  validates :registration_number, uniqueness: true 
  validates :registration_number, length: { is: 14 }
  validates :phone_number, length: { is: 10 }
  validates :email, { format: /\A\S+@.+\.\S+\z/ }
end
