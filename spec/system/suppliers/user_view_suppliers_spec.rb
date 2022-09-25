require 'rails_helper'

describe 'Usuário vê os fornecedores' do 
  it 'a partir do menu' do 
    visit root_path
    within 'nav' do 
      click_on 'Fornecedores'
    end

    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedores'
  end

  it 'e vê os fornecedores listados' do 
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

    Supplier.create!(
                      corporate_name:      'Nubank Agência de Pagamentos SA',
                      brand_name:          'Nubank',
                      registration_number: '12395673982122',
                      full_address:        'Av. Francisco Sá, 80',
                      city:                'Fortaleza',
                      state:               'CE',
                      email:               'atendimento@nubank.com',
                      phone_number:        '8599999999'
                )

    visit root_path 
    click_on 'Fornecedores'

    expect(page).to have_content 'XP Investimentos'
    expect(page).to have_content 'Guarulhos - SP'
    expect(page).to have_content 'contato@xpcorretora.com'
    expect(page).to have_content 'Nubank'
    expect(page).to have_content 'Fortaleza - CE'
    expect(page).to have_content 'atendimento@nubank.com'
  end

  it 'e não há fornecedores cadastrados' do 
    visit root_path
    click_on 'Fornecedores'

    expect(page).to have_content 'Não há fornecedores cadastrados ainda'
  end

end