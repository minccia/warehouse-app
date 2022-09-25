require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when corporate_name is empty' do
        supplier = Supplier.new(
                                corporate_name: '',
                                brand_name: 'XP Investimentos',
                                registration_number: '43281298398422',
                                full_address: 'Av. Das Palmas, 100',
                                city: 'Guarulhos',
                                state: 'SP',
                                email: 'contato@xpcorretora.com',
                                phone_number: '8599999999'
                               )

        expect(supplier).not_to be_valid
      end

      it 'false when brand_name is empty' do
        supplier = Supplier.new(
                                  corporate_name: 'XP Corretora de Investimentos LTDA',
                                  brand_name: '',
                                  registration_number: '43281298398422',
                                  full_address: 'Av. Das Palmas, 100',
                                  city: 'Guarulhos',
                                  state: 'SP',
                                  email: 'contato@xpcorretora.com',
                                  phone_number: '8599999999'
                               )
                               
        expect(supplier).not_to be_valid
      end

      it 'false when registration_number is empty' do
        supplier = Supplier.new(
                                  corporate_name: 'XP Corretora de Investimentos LTDA',
                                  brand_name: 'XP Investimentos',
                                  registration_number: '',
                                  full_address: 'Av. Das Palmas, 100',
                                  city: 'Guarulhos',
                                  state: 'SP',
                                  email: 'contato@xpcorretora.com',
                                  phone_number: '8599999999'
                               )
                               
        expect(supplier).not_to be_valid
      end

      it 'false when email is empty' do
        supplier = Supplier.new(
                                  corporate_name: 'XP Corretora de Investimentos LTDA',
                                  brand_name: 'XP Investimentos',
                                  registration_number: '43281298398422',
                                  full_address: 'Av. Das Palmas, 100',
                                  city: 'Guarulhos',
                                  state: 'SP',
                                  email: '',
                                  phone_number: '8599999999'
                               )
                               
        expect(supplier).not_to be_valid
      end

      it 'false when phone_number is empty' do
        supplier = Supplier.new(
                                  corporate_name: 'XP Corretora de Investimentos LTDA',
                                  brand_name: 'XP Investimentos',
                                  registration_number: '43281298398422',
                                  full_address: 'Av. Das Palmas, 100',
                                  city: 'Guarulhos',
                                  state: 'SP',
                                  email: 'sac@xpinvestimentos.com',
                                  phone_number: ''
                               )
                               
        expect(supplier).not_to be_valid
      end
    end

    context 'uniqueness' do 
      it 'false when registration_number has already taken' do
        Supplier.create!(
                          corporate_name: 'XP Corretora de Investimentos LTDA',
                          brand_name: 'XP Investimentos',
                          registration_number: '43281298398422',
                          full_address: 'Av. Das Palmas, 100',
                          city: 'Guarulhos',
                          state: 'SP',
                          email: 'contato@xpcorretora.com',
                          phone_number: '8599999999'
                    )
    
        second_supplier = Supplier.new(
                                        corporate_name: 'Nubank Agência Bancária S/A',
                                        brand_name: 'Nubank',
                                        registration_number: '43281298398422',
                                        full_address: 'Av. Francisco Sá, 3780',
                                        city: 'Igrejinha',
                                        state: 'RS',
                                        email: 'atendimento@nubank.com.br',
                                        phone_number: '85996436754'
                                   )
    
        expect(second_supplier).not_to be_valid
      end
    end

    context 'length' do 
      it 'false when registration_number has more than 14 characters' do 
        supplier = Supplier.new(
                                corporate_name: 'XP Corretora de Investimentos LTDA',
                                brand_name: 'XP Investimentos',
                                registration_number: '4328129839842211111111111',
                                full_address: 'Av. Das Palmas, 100',
                                city: 'Guarulhos',
                                state: 'SP',
                                email: 'contato@xpcorretora.com',
                                phone_number: '8599999999'
                            )

        expect(supplier).not_to be_valid
      end

      it 'false when registration_number has less than 14 characters' do 
        supplier = Supplier.new(
                                corporate_name: 'XP Corretora de Investimentos LTDA',
                                brand_name: 'XP Investimentos',
                                registration_number: '14811',
                                full_address: 'Av. Das Palmas, 100',
                                city: 'Guarulhos',
                                state: 'SP',
                                email: 'contato@xpcorretora.com',
                                phone_number: '8599999999'
                            )
                            
        expect(supplier).not_to be_valid
      end

      it 'false when phone_number has more than 10 characters' do 
        supplier = Supplier.new(
                                corporate_name: 'XP Corretora de Investimentos LTDA',
                                brand_name: 'XP Investimentos',
                                registration_number: '4328129839842211111111111',
                                full_address: 'Av. Das Palmas, 100',
                                city: 'Guarulhos',
                                state: 'SP',
                                email: 'contato@xpcorretora.com',
                                phone_number: '85999999999999999999999'
                            )
                            
        expect(supplier).not_to be_valid
      end

      it 'false when phone_number has less than 10 characters' do 
        supplier = Supplier.new(
                                corporate_name: 'XP Corretora de Investimentos LTDA',
                                brand_name: 'XP Investimentos',
                                registration_number: '4328129839842211111111111',
                                full_address: 'Av. Das Palmas, 100',
                                city: 'Guarulhos',
                                state: 'SP',
                                email: 'contato@xpcorretora.com',
                                phone_number: '8599'
                            )
                            
        expect(supplier).not_to be_valid
      end
    end

    context 'format' do 
      it 'false when email is not in a valid format' do 
        supplier = Supplier.new(
                                corporate_name: 'XP Corretora de Investimentos LTDA',
                                brand_name: 'XP Investimentos',
                                registration_number: '4328129839842211111111111',
                                full_address: 'Av. Das Palmas, 100',
                                city: 'Guarulhos',
                                state: 'SP',
                                email: 'uga@buga@:::!!??cooka!!?',
                                phone_number: '8599'
                            )
                            
        expect(supplier).not_to be_valid
      end
    end

  end
end
