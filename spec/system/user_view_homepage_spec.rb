require 'rails_helper'

describe 'Usuário visita a página inicial' do 
  it 'e vê o nome da app' do 
    visit root_path 

    expect(page).to have_content 'Galpões & Estoque'
  end

  it 'e vê os galpões cadastrados' do 
    Warehouse.create(
                  name:        'Galpão Guarulhos',
                  code:        'XLR',
                  area:        100_000,
                  city:        'Guarulhos',
                  address:      'Rodovia Hélio Smidt, s/n, Cumbica',
                  zip_code:    '07190-100',
                  description: 'É o maior galpão do Brasil!'
                )

    Warehouse.create(
                  name:        'Galpão Maceió',
                  code:        'ZNT',
                  area:        80_000,
                  city:        'Maceió',
                  address:      'Rodovia BR 104, Km 91, Tabuleiro do Pinto',
                  zip_code:    '57100-971',
                  description: 'Destinado para cargas internacionais'
                )

    visit root_path 

    expect(page).not_to have_content 'Não há galpões cadastrados ainda'
    expect(page).to have_content 'Galpão Guarulhos'
    expect(page).to have_content 'Código: XLR'
    expect(page).to have_content 'Área: 100000 metros quadrados'
    expect(page).to have_content 'Cidade: Guarulhos'

    expect(page).to have_content 'Galpão Maceió'
    expect(page).to have_content 'Código: ZNT'
    expect(page).to have_content 'Área: 80000 metros quadrados'
    expect(page).to have_content 'Cidade: Maceió'
  end

  it 'e não há galpões cadastrados' do 
    visit root_path 

    expect(page).to have_content 'Não há galpões cadastrados ainda'
  end

end