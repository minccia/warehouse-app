require 'rails_helper' 

describe 'Usuário vê os produtos cadastrados' do 
  let(:user) { User.create!(name: 'Paola Dobrotto', email: 'paola@email.com', password: 'password') }

  it 'se estiver autenticado' do 
    visit root_path

    within 'nav' do 
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq new_user_session_path
  end

  it 'a partir da barra de navegação' do 
    login_as user, scope: :user
    visit root_path 

    within 'nav' do
      click_on 'Modelos de Produtos'
    end

    expect(current_path).to eq product_models_path
  end

  it 'com sucesso' do 
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

    login_as user, scope: :user
    visit root_path 
    
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Notebook'
    expect(page).to have_content 'NOTEBOOKSANS-XPTO902'
    expect(page).to have_content 'Samsung'
    expect(page).to have_content 'Smartphone Samsung Galaxy S9'
    expect(page).to have_content 'SMARTGALAXY-10929222'
    expect(page).to have_content 'Samsung'
  end

  it 'e não há modelos de produtos cadastrados' do 
    login_as user, scope: :user
    visit root_path 
    visit root_path 
    click_on 'Modelos de Produtos'

    expect(page).to have_content 'Não há modelos de produtos cadastrados ainda'
  end
end