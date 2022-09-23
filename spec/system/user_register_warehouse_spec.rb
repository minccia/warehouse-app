require 'rails_helper'

describe 'Usuário registra um galpão' do 
  it 'a partir da tela inicial' do
     visit root_path 
     click_on 'Novo Galpão'

     expect(page).to have_content 'Novo Galpão'
     expect(page).to have_field 'Nome'
     expect(page).to have_field 'Descrição'
     expect(page).to have_field 'Código'
     expect(page).to have_field 'Área'
     expect(page).to have_field 'Cidade'
     expect(page).to have_field 'Endereço'
     expect(page).to have_field 'CEP'
  end

  it 'com sucesso' do 
    visit root_path 
    click_on 'Novo Galpão'

    fill_in 'Nome', with: 'Galpão Guarulhos'
    fill_in 'Descrição', with: 'É o maior galpão do Brasil!'
    fill_in 'Código', with: 'XLR'
    fill_in 'Área', with: '100000'
    fill_in 'Cidade', with: 'Guarulhos'
    fill_in 'Endereço', with: 'Rodovia Hélio Smidt, s/n, Cumbica'
    fill_in 'CEP', with: '07190100'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão criado com sucesso'
    expect(page).to have_link 'Galpão Guarulhos'
    expect(page).to have_content 'XLR'
    expect(page).to have_content '100000 metros quadrados'
  end

  it 'e não preenche todos os campos' do 
    visit root_path 
    click_on 'Novo Galpão'

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Enviar'

    expect(current_path).to eq warehouses_path
    expect(page).to have_content 'Galpão não cadastrado'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end

end