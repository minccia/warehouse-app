require 'rails_helper'

describe 'Usuário deleta um galpão' do 
  let(:user) { User.create!(name: 'Paola Dobrotto', email: 'paola@email.com', password: 'password') }

  it 'com sucesso' do 
    Warehouse.create!(
                      name:        'Galpão Guarulhos',
                      code:        'XLR',
                      area:        100_000,
                      city:        'Guarulhos',
                      address:     'Rodovia Hélio Smidt, s/n, Cumbica',
                      zip_code:    '07190100',
                      description: 'É o maior galpão do Brasil!'
                  )

    login_as user, scope: :user
    visit root_path
    click_on 'Galpão Guarulhos'
    click_on 'Deletar'

    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Galpão Guarulhos'
    expect(page).not_to have_content 'XLR'
    expect(page).not_to have_content '100000 metros quadrados'
    expect(page).not_to have_content 'Guarulhos'
  end

  it 'e não apaga outros galpões' do 
    target_wh = Warehouse.create!(
                                  name:        'Galpão Guarulhos',
                                  code:        'XLR',
                                  area:        100_000,
                                  city:        'Guarulhos',
                                  address:     'Rodovia Hélio Smidt, s/n, Cumbica',
                                  zip_code:    '07190100',
                                  description: 'É o maior galpão do Brasil!'
                               )
    Warehouse.create!(
                      name:        'Galpão Natal',
                      code:        'NTL',
                      area:        150_000,
                      city:        'Natal',
                      address:     'Praia do Amor',
                      zip_code:    '10010995',
                      description: 'É um galpão cheio de adesivos de golfinhos'
                 )

    login_as user, scope: :user
    visit warehouse_path(target_wh.id)
    click_on 'Deletar'
    
    expect(current_path).to eq root_path
    expect(page).to have_content 'Galpão removido com sucesso'
    expect(page).not_to have_content 'Galpão Guarulhos'
    expect(page).not_to have_content 'XLR'
    expect(page).not_to have_content '100000 metros quadrados'
    expect(page).to have_content 'Galpão Natal'
    expect(page).to have_content 'NTL'
    expect(page).to have_content '150000 metros quadrados'
  end

end