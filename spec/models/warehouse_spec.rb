require 'rails_helper'

RSpec.describe Warehouse, type: :model do 
  describe '#valid?' do 
    context 'presence' do 
      it 'false when name is empty' do 
        warehouse = Warehouse.new(
                                  name: '',
                                  description:'É o maior galpão do Brasil',
                                  code: 'XLR',
                                  city: 'Guarulhos',
                                  area: 100_000,
                                  zip_code: '60337670',
                                  address: 'Rua Padre José Anchieta, 100',
                              )
        
        expect(warehouse).not_to be_valid 
      end
  
      it 'false when description is empty' do 
        warehouse = Warehouse.new(
                                  name: 'Guarulhos',
                                  description:'',
                                  code: 'XLR',
                                  city: 'Guarulhos',
                                  area: 100_000,
                                  zip_code: '60337670',
                                  address: 'Rua Padre José Anchieta, 100',
                                )
          
        expect(warehouse).not_to be_valid
      end
  
      it 'false when code is empty' do 
        warehouse = Warehouse.new(
                                  name: 'Guarulhos',
                                  description:'É o maior galpão do Brasil',
                                  code: '',
                                  city: 'Guarulhos',
                                  area: 100_000,
                                  zip_code: '60337670',
                                  address: 'Rua Padre José Anchieta, 100',
                              )
        
        expect(warehouse).not_to be_valid
      end
  
      it 'false when area is empty' do 
        warehouse = Warehouse.new(
                                  name: 'Guarulhos',
                                  description:'É o maior galpão do Brasil',
                                  code: 'XLR',
                                  area: '',
                                  city: 'Guarulhos',
                                  zip_code: '60337670',
                                  address: 'Rua Padre José Anchieta, 100',
                              )
        
        expect(warehouse).not_to be_valid
      end
  
      it 'false when zip_code is empty' do 
        warehouse = Warehouse.new(
                                  name: 'Guarulhos',
                                  description:'É o maior galpão do Brasil',
                                  code: 'XLR',
                                  city: 'Guarulhos',
                                  area: 100_000,
                                  zip_code: '',
                                  address: 'Rua Padre José Anchieta, 100',
                              )
  
        expect(warehouse).not_to be_valid
      end
  
      it 'false when address is empty' do 
        warehouse = Warehouse.new(
                                  name: 'Guarulhos',
                                  description:'É o maior galpão do Brasil',
                                  code: 'XLR',
                                  city: 'Guarulhos',
                                  area: 100_000,
                                  zip_code: '60337670',
                                  address: '',
                              )
        
        expect(warehouse).not_to be_valid
      end
 
      it 'false when city is empty' do 
        warehouse = Warehouse.new(
                                  name: 'Guarulhos',
                                  description:'É o maior galpão do Brasil',
                                  code: 'XLR',
                                  city: '',
                                  area: 100_000,
                                  zip_code: '60337670',
                                  address: '',
                              )
        
        expect(warehouse).not_to be_valid
      end
    end

    context 'uniqueness' do 
      it 'false when code is already in use' do 
        Warehouse.create(
                          name: 'Guarulhos',
                          description:'É o maior galpão do Brasil',
                          code: 'XLR',
                          city: 'Guarulhos',
                          area: 100_000,
                          zip_code: '60337670',
                          address: 'Rua Padre Anchieta, 100',
                        )

        warehouse = Warehouse.new(
                                   name: 'Rio de Janeiro',
                                   description:'Não é tão grande assim',
                                   code: 'XLR',
                                   city: 'Rio de Janeiro',
                                   area: 80_000,
                                   zip_code: '34530700',
                                   address: 'Rua São José Gonçalo, 500',
                                )

        expect(warehouse).not_to be_valid
      end

      it 'false when name is already in use' do 
        Warehouse.create(
                          name: 'Guarulhos',
                          description:'É o maior galpão do Brasil',
                          code: 'XLR',
                          city: 'Guarulhos',
                          area: 100_000,
                          zip_code: '60337670',
                          address: 'Rua Padre Anchieta, 100',
                        )

        warehouse = Warehouse.new(
                                   name: 'Guarulhos',
                                   description:'Não é tão grande assim',
                                   code: 'CDU',
                                   city: 'Guarulhos',
                                   area: 80_000,
                                   zip_code: '34530700',
                                   address: 'Rua São José Gonçalo, 500',
                                )

        expect(warehouse).not_to be_valid
      end
    end

    context 'lenght' do 
      it 'false when code has more than 3 characters' do 
        warehouse = Warehouse.new(
                                  name: 'Rio de Janeiro',
                                  description:'Não é tão grande assim',
                                  code: 'CDUAB',
                                  area: 80_000,
                                  city: 'Rio de janeiro',
                                  zip_code: '60553230',
                                  address: 'Rua São José Gonçalo, 500',
                                 )

        expect(warehouse).not_to be_valid
      end

      it 'false when zip_code has more characters than permited' do 
        warehouse = Warehouse.new(
                                  name: 'Rio de Janeiro',
                                  description:'Não é tão grande assim',
                                  code: 'CDU',
                                  area: 80_000,
                                  city: 'Rio de janeiro',
                                  zip_code: '3453027003',
                                  address: 'Rua São José Gonçalo, 500',
                                 )

        expect(warehouse).not_to be_valid
      end

      it 'false when zip_code has less characters than permited' do 
        warehouse = Warehouse.new(
                                  name: 'Rio de Janeiro',
                                  description:'Não é tão grande assim',
                                  code: 'CDU',
                                  area: 80_000,
                                  city: 'Rio de janeiro',
                                  zip_code: '34703',
                                  address: 'Rua São José Gonçalo, 500',
                                 )

        expect(warehouse).not_to be_valid
      end
    end
  end

end