require 'rails_helper'

describe 'Usuário edita um forneceodr' do 
  it 'a partir da página de fornecedores' do
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

    visit root_path 
    click_on 'Fornecedores'
    click_on 'XP Investimentos'
    click_on 'Editar Fornecedor'

    expect(current_path).to eq edit_supplier_path(supplier.id)
    expect(page).to have_field 'Razão social',       with: 'XP Corretora de Investimentos LTDA'
    expect(page).to have_field 'Nome fantasia',      with: 'XP Investimentos'
    expect(page).to have_field 'CNPJ',               with: '43281298398422'
    expect(page).to have_field 'Endereço comercial', with: 'Av. Das Palmas, 100'
    expect(page).to have_field 'Cidade',             with: 'Guarulhos'
    expect(page).to have_field 'Estado',             with: 'SP'
    expect(page).to have_field 'Telefone',           with: '8599999999'
  end

  it 'com sucesso' do
    Supplier.create!(
                      corporate_name:      'XP Corretora de Investimentos LTDA',
                      brand_name:          'XP Investimentos',
                      registration_number: '43281298398422',
                      full_address:        'Av. Das Palmas, 100',
                      city:                'Guarulhos',
                      state:               'SP',
                      email:               'contato@xpcorretora.com',
                      phone_number:        '8599999999'
                )

    visit root_path 
    click_on 'Fornecedores'
    click_on 'XP Investimentos'
    click_on 'Editar Fornecedor'

    fill_in 'Nome fantasia',  with: 'Chululu Brinquedos'
    fill_in 'Cidade',         with: 'Suzano'
    fill_in 'Email',          with: 'contato@chululubrinquedos.com'
    click_on 'Enviar' 

    expect(page).to have_content 'Fornecedor atualizado com sucesso'
    expect(page).to have_content 'Chululu Brinquedos'
    expect(page).to have_content 'contato@chululubrinquedos.com'
    expect(page).to have_content 'Suzano - SP'
  end

  it 'e não preenche os dados corretamente' do
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

    visit root_path 
    click_on 'Fornecedores'
    click_on 'XP Investimentos'
    click_on 'Editar Fornecedor'

    fill_in 'Razão social',  with: ''
    fill_in 'Nome fantasia', with: ''
    fill_in 'CNPJ',          with: ''
    fill_in 'Email',         with: ''
    click_on 'Enviar'

    expect(current_path).to eq supplier_path(supplier.id)
    expect(page).to have_content 'Fornecedor não atualizado'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Razão social não pode ficar em branco'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Email não pode ficar em branco'
  end

end