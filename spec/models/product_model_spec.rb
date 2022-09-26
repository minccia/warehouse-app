require 'rails_helper'

RSpec.describe ProductModel, type: :model do
  describe '#valid?' do 
    context 'presence' do 
      it 'false when name is empty' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )
  
        pm = ProductModel.new(
                              name:     '',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                          )
  
        expect(pm).not_to be_valid
      end
  
      it 'false when sku is empty' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )
  
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      '',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                          )
  
        expect(pm).not_to be_valid
      end
  
      it 'false when weight is empty' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )
  
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '',
                              width:    '50',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                          )
  
        expect(pm).not_to be_valid
      end
  
      it 'false when width is empty' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )
  
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                          )
  
        expect(pm).not_to be_valid
      end
  
      it 'false when height is empty' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )
  
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '',
                              depth:    '10',
                              supplier: supplier
                          )
  
        expect(pm).not_to be_valid
      end
  
      it 'false when depth is empty' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )
  
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '',
                              supplier: supplier
                          )
  
        expect(pm).not_to be_valid
      end
  
      it 'false when supplier is empty' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )
  
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '10',
                              supplier: nil
                          )
  
        expect(pm).not_to be_valid
      end
    end

    context 'uniqueness' do 
      it 'false when sku is already in use' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )
  
        ProductModel.create(
                            name:     'Notebook',
                            sku:      'NOTEBOOKSANS-XPTO902',
                            weight:   '1000',
                            width:    '50',
                            height:   '45',
                            depth:    '10',
                            supplier: supplier
                         )
        second_model = ProductModel.create(
                                           name:     'Notebook Dobrável',
                                           sku:      'NOTEBOOKSANS-XPTO902',
                                           weight:   '500',
                                           width:    '60',
                                           height:   '20',
                                           depth:    '5',
                                           supplier: supplier
                         )

        expect(second_model).not_to be_valid
      end
    end

    context 'length' do 
      it 'false when sku has more than 20 characters' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902999999999999',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '',
                              supplier: supplier
                          )    

        expect(pm).not_to be_valid
      end

      it 'false when sku has less than 20 characters' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTESANS-99',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end
    end

    context 'numericality' do 
      it 'false when weight is less than 0' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '-5',
                              width:    '50',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end

      it 'false when weight is equal to 0' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '0',
                              width:    '50',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end

      it 'false when width is less than 0' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '-5',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end

      it 'false when width is equal to 0' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '0',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end

      it 'false when height is less than 0' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '-5',
                              depth:    '10',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end

      it 'false when height is equal to 0' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '0',
                              depth:    '10',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end

      it 'false when depth is less than 0' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '-5',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end

      it 'false when depth is equal to 0' do 
        supplier = Supplier.create!(
                                    corporate_name:      'Samsung Technologies Corporation LTDA',
                                    brand_name:          'Samsung',
                                    registration_number: '12345678912345',
                                    email:               'atendimento@samsung.com',
                                    phone_number:        '8599999999'
                          )    
        pm = ProductModel.new(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '0',
                              supplier: supplier
                          )    
                          
        expect(pm).not_to be_valid
      end
    end

  end
end
