require 'rails_helper'

RSpec.describe Order, type: :model do
  context 'When creating a new order' do 
    subject(:order) do
      Order.new(warehouse_id: '3', supplier_id: '2',
                user_id: '1', estimated_delivery_date: '2054-02-20'
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

      it 'false when code is empty' do 
        order.code = nil 
        expect(order).not_to be_valid
      end

      it 'false when estimated delivery date is not a future date' do
        order.estimated_delivery_date = '1562-09-01'
        expect(order).not_to be_valid
      end 
    end

    describe 'generate a random code' do 
      it 'and assign it to the code attribute' do 
        warehouse = Warehouse.create!(
                                      name:        'Galpão Guarulhos',
                                      code:        'XLR',
                                      area:        100_000,
                                      city:        'Guarulhos',
                                      address:     'Rodovia Hélio Smidt, s/n, Cumbica',
                                      zip_code:    '07190100',
                                      description: 'É o maior galpão do Brasil!'
                                    )

        supplier = Supplier.create!(
                                    corporate_name:      'XP Corretora de Investimentos LTDA',
                                    brand_name:          'XP Investimentos',
                                    registration_number: '43281298398422',
                                    full_address:        'Av. Das Palmas, 100',
                                    city:                'Guarulhos',
                                    state:               'SP',
                                    email:               'contato@xpcorretora.com',
                                    phone_number:        '8599999999'
                )

        user = User.create(name: 'Paola', email: 'paola@email.com',
                           password: '32823144')
        
        order = Order.new(user: user, warehouse: warehouse, 
                          supplier: supplier, estimated_delivery_date: '2054-10-01')  
        
        order.save!
        expect(order.code).not_to be_empty
        expect(order.code.length).to eq 10
      end

      it 'and the code must be unique' do 
        warehouse = Warehouse.create!(
                                      name:        'Galpão Guarulhos',
                                      code:        'XLR',
                                      area:        100_000,
                                      city:        'Guarulhos',
                                      address:     'Rodovia Hélio Smidt, s/n, Cumbica',
                                      zip_code:    '07190100',
                                      description: 'É o maior galpão do Brasil!'
                                    )

        supplier = Supplier.create!(
                                    corporate_name:      'XP Corretora de Investimentos LTDA',
                                    brand_name:          'XP Investimentos',
                                    registration_number: '43281298398422',
                                    full_address:        'Av. Das Palmas, 100',
                                    city:                'Guarulhos',
                                    state:               'SP',
                                    email:               'contato@xpcorretora.com',
                                    phone_number:        '8599999999'
                )

        user = User.create(name: 'Paola', email: 'paola@email.com',
                           password: '32823144')
        
        first_order = Order.create!(user: user, warehouse: warehouse, 
                          supplier: supplier, estimated_delivery_date: '2054-10-01')  
        
        second_order = Order.new(user: user, warehouse: warehouse, 
                                 supplier: supplier, estimated_delivery_date: '2058-05-03') 

        second_order.save!
        expect(second_order.code).not_to be_eql first_order.code
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
