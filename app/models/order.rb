class Order < ApplicationRecord
  belongs_to :warehouse
  belongs_to :supplier
  belongs_to :user

  before_validation :generate_code
  validates :estimated_delivery_date, :code, presence: true

  private
    def generate_code
      self.code = SecureRandom.alphanumeric(10).upcase
    end
end
