require 'rails_helper'

describe 'Usuário edita um galpão' do 
  it 'a partir da página de detalhes' do 
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
    click_on 'Editar'
                  
    expect(page).to have_content 'Editar Galpão'
    expect(page).to have_field 'Nome', with: 'Galpão Guarulhos'
    expect(page).to have_field 'Descrição', with: 'É o maior galpão do Brasil!'
    expect(page).to have_field 'Código', with: 'XLR'
    expect(page).to have_field 'Área', with: 100_000
    expect(page).to have_field 'Cidade', with: 'Guarulhos'
    expect(page).to have_field 'Endereço', with: 'Rodovia Hélio Smidt, s/n, Cumbica'
    expect(page).to have_field 'CEP', with: '07190100'
  end

  it 'e atualiza o galpão com sucesso' do 
    warehouse = Warehouse.create!(
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
    click_on 'Editar'

    fill_in 'Nome', with: 'Sapataria Nova'
    fill_in 'Código', with: 'SPN'
    fill_in 'Área', with: '80000'
    click_on 'Enviar'

    expect(current_path).to eq warehouse_path(warehouse.id)
    expect(page).to have_content 'Galpão atualizado com sucesso'
    expect(page).to have_content 'Sapataria Nova'
    expect(page).to have_content 'Código: SPN'
    expect(page).to have_content 'Área: 80000 metros quadrados'
  end
  
  it 'e mantém os campos obrigatórios' do 
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
    click_on 'Editar'

    fill_in 'Nome', with: ''
    fill_in 'Código', with: ''
    fill_in 'Área', with: ''
    click_on 'Enviar'
    
    expect(page).to have_content 'Galpão não atualizado'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Código não pode ficar em branco'
    expect(page).to have_content 'Área não pode ficar em branco'
  end

end