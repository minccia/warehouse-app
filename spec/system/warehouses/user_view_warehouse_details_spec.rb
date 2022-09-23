require 'rails_helper'

describe 'Usuário vê detalhes de um galpão' do 
  it 'e vê informações adicionais' do  
    Warehouse.create!(
        name:        'Galpão Guarulhos',
        code:        'XLR',
        area:        100_000,
        city:        'Guarulhos',
        address:      'Rodovia Hélio Smidt, s/n, Cumbica',
        zip_code:    '07197100',
        description: 'É o maior galpão do Brasil!'
      )

    visit root_path 
    click_on 'Galpão Guarulhos'

    expect(page).to have_content 'Galpão Guarulhos'
    expect(page).to have_content 'Código: XLR'
    expect(page).to have_content 'Área: 100000 metros quadrados'
    expect(page).to have_content 'Cidade: Guarulhos'
    expect(page).to have_content 'Endereço: Rodovia Hélio Smidt, s/n, Cumbica'
    expect(page).to have_content 'CEP: 07197-100'
    expect(page).to have_content 'É o maior galpão do Brasil!'
  end

  it 'e retorna pra tela incial' do 
    Warehouse.create!(
      name:        'Galpão Guarulhos',
      code:        'XLR',
      area:        100_000,
      city:        'Guarulhos',
      address:      'Rodovia Hélio Smidt, s/n, Cumbica',
      zip_code:    '07190100',
      description: 'É o maior galpão do Brasil!'
    )

    visit root_path 
    click_on 'Galpão Guarulhos'
    click_on 'Início'
    expect(current_path).to eq root_path
  end
end