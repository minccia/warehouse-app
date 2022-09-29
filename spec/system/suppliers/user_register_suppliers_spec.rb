require 'rails_helper' 

describe 'Usuário cadastra um fornecedor' do 
  let(:user) { User.create!(name: 'Paola Dobrotto', email: 'paola@email.com', password: 'password') }

  it 'a partir do formulário' do 
    login_as user, scope: :user
    visit root_path
    click_on 'Fornecedores'
    click_on 'Novo Fornecedor'

    expect(page).to have_content 'Cadastro de Fornecedores'
    expect(page).to have_field 'Razão social'
    expect(page).to have_field 'Nome fantasia'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Endereço comercial'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'Email'
    expect(page).to have_field 'Telefone'
  end

  it 'com sucesso' do 
    login_as user, scope: :user
    visit new_supplier_path 

    fill_in 'Razão social',       with: 'XP Investimentos e Corretoria LTDA'
    fill_in 'Nome fantasia',      with: 'XP Investimentos'
    fill_in 'CNPJ',               with: '12345678912345'
    fill_in 'Endereço comercial', with: 'Av. Francisco Sá, 3780 - Carlito Pamplona'
    fill_in 'Cidade',             with: 'Fortaleza'
    fill_in 'Estado',             with: 'CE'
    fill_in 'Email',              with: 'suporte@xpinvestimentos.com'
    fill_in 'Telefone',           with: '8599999999'

    click_on 'Enviar'
    
    expect(current_path).to eq suppliers_path
    expect(page).to have_content 'Fornecedor criado com sucesso'
    expect(page).to have_content 'XP Investimentos'
    expect(page).to have_content 'Fortaleza - CE'
    expect(page).to have_content 'suporte@xpinvestimentos.com'
  end

  it 'e não preenche todos os campos' do 
    login_as user, scope: :user
    visit new_supplier_path

    fill_in 'Razão social',  with: ''
    fill_in 'Nome fantasia', with: ''
    fill_in 'CNPJ',          with: ''
    fill_in 'Email',         with: ''

    click_on 'Enviar'
    
    expect(page).to have_content 'Fornecedor não cadastrado'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Razão social não pode ficar em branco'
    expect(page).to have_content 'Nome fantasia não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Email não pode ficar em branco'
  end
  
end