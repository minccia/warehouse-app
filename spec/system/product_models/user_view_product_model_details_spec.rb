require 'rails_helper'

describe 'Usuário vê detalhes de um modelo de produto' do 
  it 'e vê informações adicionais' do 
    supplier = Supplier.create!(
                                corporate_name:      'Samsung Technologies Corporation LTDA',
                                brand_name:          'Samsung',
                                registration_number: '12345678912345',
                                email:               'atendimento@samsung.com',
                                phone_number:        '8599999999'
                          )

    pm = ProductModel.create!(
                              name:     'Notebook',
                              sku:      'NOTEBOOKSANS-XPTO902',
                              weight:   '1000',
                              width:    '50',
                              height:   '45',
                              depth:    '10',
                              supplier: supplier
                      )

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Notebook'

    expect(current_path).to eq product_model_path(pm.id)
    expect(page).to have_content 'Notebook'
    expect(page).to have_content 'SKU: NOTEBOOKSANS-XPTO902'
    expect(page).to have_content 'Peso: 1000 gramas'
    expect(page).to have_content 'Dimensões: 45 X 50 X 10'
    expect(page).to have_content 'Fornecedor: Samsung'
  end

end