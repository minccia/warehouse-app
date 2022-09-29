require 'rails_helper' 

describe 'Usuário vê os produtos cadastrados' do 
  it 'se estiver autentadicado' do 
    visit root_path

    within 'nav' do 
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da barra de navegação' do 
    User.create!(
                  name: 'Paola Dobrotto',
                  email: 'paola@email.com',
                  password: 'password'
                )
    
    visit root_path 
    click_on 'Fazer Login'

    within 'form' do
      fill_in 'Email', with: 'paola@email.com' 
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do 
    User.create!(
                  name: 'Paola Dobrotto',
                  email: 'paola@email.com',
                  password: 'password'
                )

    supplier = Supplier.create!(
                                corporate_name:      'Samsung Technologies Corporation LTDA',
                                brand_name:          'Samsung',
                                registration_number: '12345678912345',
                                email:               'atendimento@samsung.com',
                                phone_number:        '8599999999'
                          )

    ProductModel.create!(
                          name:     'Notebook',
                          sku:      'NOTEBOOKSANS-XPTO902',
                          weight:   '1000',
                          width:    '50',
                          height:   '45',
                          depth:    '10',
                          supplier: supplier
                      )

    ProductModel.create!(
                        name:     'Smartphone Samsung Galaxy S9',
                        sku:      'SMARTGALAXY-10929222',
                        weight:   '200',
                        width:    '20',
                        height:   '30',
                        depth:    '4',
                        supplier: supplier
                      )

    visit root_path 
    click_on 'Fazer Login'

    within 'form' do
      fill_in 'Email', with: 'paola@email.com' 
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Notebook'
    expect(page).to have_content 'NOTEBOOKSANS-XPTO902'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Smartphone Samsung Galaxy S9'
    expect(page).to have_content 'SMARTGALAXY-10929222'
    expect(page).to have_content 'Samsung'
  end

  it 'e não há modelos de produtos cadastrados' do 
    User.create!(
                  name: 'Paola Dobrotto',
                  email: 'paola@email.com',
                  password: 'password'
                )
    
    visit root_path 
    click_on 'Fazer Login'

    within 'form' do
      fill_in 'Email', with: 'paola@email.com' 
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end
    
    visit root_path 
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Não há modelos de produtos cadastrados ainda'
  end
end