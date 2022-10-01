require 'rails_helper' 

describe 'Usuário cria um novo pedido' do 
  let(:user) { User.create!(name: 'Paola Dobrotto', email: 'paola@email.com', password: 'password') }

  it 'e deve estar autenticado' do 
    visit root_path 
    click_on 'Novo Pedido'

    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da tela de pedidos' do 
    warehouse = Warehouse.create!(
                                  name:        'Galpão Guarulhos',
                                  code:        'XLR',
                                  area:        100_000,
                                  city:        'Guarulhos',
                                  address:     'Rodovia Hélio Smidt, s/n, Cumbica',
                                  zip_code:    '07190100',
                                  description: 'É o maior galpão do Brasil!'
                )

    Warehouse.create!(
                      name:        'Galpão Maceió',
                      code:        'ZNT',
                      area:        80_000,
                      city:        'Maceió',
                      address:     'Rodovia BR 104, Km 91, Tabuleiro do Pinto',
                      zip_code:    '57100971',
                      description: 'Destinado para cargas internacionais'
                )

    supplier = Supplier.create!(
                                corporate_name:      'Samsung Technologies Corporation LTDA',
                                brand_name:          'Samsung',
                                registration_number: '12345678912345',
                                email:               'atendimento@samsung.com',
                                phone_number:        '8599999999'
                   )            

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

    allow(SecureRandom).to receive(:alphanumeric).with(10).and_return('ABC1234567')

    login_as user, scope: :user
    visit root_path 
    within 'nav' do 
      click_on 'Novo Pedido'
    end

    select 'XLR - Galpão Guarulhos', from: 'Galpão Destino'
    select 'Samsung - Samsung Technologies Corporation LTDA | 12.345.678/9123-45', from: 'Fornecedor' 
    fill_in 'Data prevista de entrega', with: '20/12/2022'
    click_on 'Enviar'

    expect(page).to have_content 'Pedido criado com sucesso'
    expect(page).to have_content 'Pedido ABC1234567'
    expect(page).to have_content 'Galpão Destino: XLR - Galpão Guarulhos'
    expect(page).to have_content 'Fornecedor: Samsung - Samsung Technologies Corporation LTDA | 12.345.678/9123-45'
    expect(page).to have_content 'Data prevista de entrega: 20/12/2022'
    expect(page).to have_content 'Usuário responsável: Paola Dobrotto <paola@email.com>'
    expect(page).not_to have_content 'Galpão Maceió'
    expect(page).not_to have_content 'XP Corretora de Investimentos LTDA'    
  end

  it 'e não preenche todos os dados' do 
    Warehouse.create!(
                      name:        'Galpão Maceió',
                      code:        'ZNT',
                      area:        80_000,
                      city:        'Maceió',
                      address:     'Rodovia BR 104, Km 91, Tabuleiro do Pinto',
                      zip_code:    '57100971',
                      description: 'Destinado para cargas internacionais'
                )

    Supplier.create!(
                      corporate_name:      'Samsung Technologies Corporation LTDA',
                      brand_name:          'Samsung',
                      registration_number: '12345678912345',
                      email:               'atendimento@samsung.com',
                      phone_number:        '8599999999'
                )   
    
    login_as user, scope: :user
    visit new_order_path
    fill_in 'Data prevista de entrega', with: ''
    click_on 'Enviar'

    expect(page).to have_content 'Pedido não cadastrado'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Data prevista de entrega não pode ficar em branco'
    expect(page).to have_content 'Galpão Destino é obrigatório(a)'
    expect(page).to have_content 'Fornecedor é obrigatório(a)'
  end

end