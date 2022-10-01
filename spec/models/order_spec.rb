require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'Creating a new order' do 
    subject(:order) do
      Order.new(warehouse_id: '3', supplier_id: '2',
                user_id: '1', estimated_delivery_date: '20/12/2022'
              )
    end
  
    describe '#valid?' do 
      it 'false when destination warehouse is empty' do
        order.warehouse_id = nil 
        expect(order).not_to be_valid
      end
  
      it 'false when supplier is empty' do 
        order.supplier_id = nil
        expect(order).not_to be_valid
      end
  
      it 'false when user_id is empty' do 
        order.user_id = nil 
        expect(order).not_to be_valid
      end
  
      it 'false when estimated delivery date is empty' do 
        order.estimated_delivery_date = nil 
        expect(order).not_to be_valid
      end
    end
  end

  context 'Showing order details' do 
    describe '#description' do 
      it 'shows name and email' do 
        user = User.new(name: 'Paola Dobrotto',
                        email: 'paola@email.com')

        expect(user.description).to eq 'Paola Dobrotto <paola@email.com>'
      end
    end
  end

end
