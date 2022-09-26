require 'rails_helper'

describe 'Usuário registra um modelo de um produto' do 
  it 'a partir de um formulário' do 
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Novo Modelo de produto'

    expect(current_path).to eq new_product_model_path
    expect(page).to have_content 'Criando um novo modelo'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'SKU'
    expect(page).to have_field 'Peso'
    expect(page).to have_field 'Largura'
    expect(page).to have_field 'Altura'
    expect(page).to have_field 'Profundidade'
    expect(page).to have_select 'Fornecedor'
    expect(page).to have_button 'Enviar'
  end

  it 'com sucesso' do 
    supplier = Supplier.create!(
                                corporate_name:      'Samsung Technologies Corporation LTDA',
                                brand_name:          'Samsung',
                                registration_number: '12345678912345',
                                email:               'atendimento@samsung.com',
                                phone_number:        '8599999999'
                          )

    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Novo Modelo de produto'

    fill_in 'Nome',         with: 'Smartphone Samsung Galaxy S9'
    fill_in 'SKU',          with: 'SAMSUNG-GLX123456789'
    fill_in 'Peso',         with: '100'
    fill_in 'Largura',      with: '20'
    fill_in 'Altura',       with: '30'
    fill_in 'Profundidade', with: '4'
    select 'Samsung',       from: 'Fornecedor'
    click_on 'Enviar'

    expect(page).to have_content 'Modelo criado com sucesso'
    expect(page).to have_content 'Smartphone Samsung Galaxy S9'
    expect(page).to have_content 'SAMSUNG-GLX123456789'
    expect(page).to have_content 'Samsung'
  end

  it 'e não preenche todos os campos' do 
    visit root_path
    click_on 'Modelos de Produtos'
    click_on 'Novo Modelo de produto'

    fill_in 'Nome',         with: ''
    fill_in 'SKU',          with: ''
    select '',              from: 'Fornecedor'
    click_on 'Enviar'

    expect(page).to have_content 'Modelo não cadastrado'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'SKU não pode ficar em branco'
    expect(page).to have_content 'Supplier é obrigatório(a)'
  end

end