require 'rails_helper'

describe 'Usuário vê detalhes de um fornecedor' do 
  it 'e vê informações adicionais' do 
    supplier =  Supplier.create!(
                            corporate_name: 'XP Corretora de Investimentos LTDA',
                            brand_name: 'XP Investimentos',
                            registration_number: '43281298398422',
                            full_address: 'Av. Das Palmas, 100',
                            city: 'Guarulhos',
                            state: 'SP',
                            email: 'contato@xpcorretora.com',
                            phone_number: '8599999999'
                              )
   
    visit root_path 
    click_on 'Fornecedores'
    click_on 'XP Investimentos'

    expect(current_path).to eq supplier_path(supplier.id)
    expect(page).to have_content 'Razão social: XP Corretora de Investimentos LTDA'
    expect(page).to have_content 'Nome fantasia: XP Investimentos'
    expect(page).to have_content 'CNPJ: 43.281.298/3984-22'
    expect(page).to have_content 'Endereço comercial: Av. Das Palmas, 100'
    expect(page).to have_content 'Guarulhos - SP'
    expect(page).to have_content 'Email: contato@xpcorretora.com'
    expect(page).to have_content '(85) 9999-9999'
  end

  it 'e retorna para a página inicial' do 
    supplier =  Supplier.create!(
                            corporate_name: 'XP Corretora de Investimentos LTDA',
                            brand_name: 'XP Investimentos',
                            registration_number: '43281298398422',
                            full_address: 'Av. Das Palmas, 100',
                            city: 'Guarulhos',
                            state: 'SP',
                            email: 'contato@xpcorretora.com',
                            phone_number: '8599999999'
                              )
   
    visit root_path 
    click_on 'Fornecedores'
    click_on 'XP Investimentos'
    click_on 'Início'

    expect(current_path).to eq root_path
  end

  it 'e vê os modelos de produtos associados a ele' do 
    supplier = Supplier.create!(
                                corporate_name: 'Samsung Technologies Corporation LTDA',
                                brand_name: 'Samsung',
                                registration_number: '12345678912345',
                                email: 'atendimento@samsung.com',
                                phone_number: '8599999999'
                          )

    ProductModel.create!(
                        name: 'Notebook',
                        sku: 'NOTEBOOKSANS-XPTO90',
                        weight: '1000',
                        width: '50',
                        height: '45',
                        depth:'10',
                        supplier: supplier
                      )

    ProductModel.create!(
                        name: 'Smartphone Samsung Galaxy S9',
                        sku: 'SMARTGALAXY-10929',
                        weight: '200',
                        width: '20',
                        height: '30',
                        depth:'4',
                        supplier: supplier
                      )
   
    visit root_path 
    click_on 'Fornecedores'
    click_on 'Samsung'

    expect(page).to have_content 'Notebook'
    expect(page).to have_content 'SKU: NOTEBOOKSANS-XPTO90'
    expect(page).to have_content 'Smartphone Samsung Galaxy S9'
    expect(page).to have_content 'SKU: SMARTGALAXY-10929'
  end

  it 'e não há modelos de produtos associados a ele' do 
    Supplier.create!(
                      corporate_name: 'Samsung Technologies Corporation LTDA',
                      brand_name: 'Samsung',
                      registration_number: '12345678912345',
                      email: 'atendimento@samsung.com',
                      phone_number: '8599999999'
                   )

    visit root_path 
    click_on 'Fornecedores'
    click_on 'Samsung'

    expect(page).to have_content 'Este fornecedor ainda não possui modelos de produtos'
  end

end