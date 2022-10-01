require 'rails_helper'

describe 'Usuário se autentica' do 
  it 'com sucesso' do
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
      expect(page).not_to have_link 'Entrar'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Olá, Paola Dobrotto <paola@email.com>'
    end

    expect(page).to have_content 'Login efetuado com sucesso'
  end

  it 'e faz logout' do 
    User.create!(name: 'Paola Dobrotto', email: 'paola@email.com', password: 'password')
    
    visit root_path 
    click_on 'Fazer Login'

    within 'form' do
      fill_in 'Email', with: 'paola@email.com' 
      fill_in 'Senha', with: 'password'
      click_on 'Entrar'
    end

    within 'nav' do 
      click_on 'Sair'
    end

    expect(page).to have_content 'Fazer Login Para continuar, faça login ou registre-se'
    expect(page).not_to have_button 'Sair'
    expect(page).to have_link 'Fazer Login'
    expect(page).not_to have_content 'Olá, Paola Dobrotto <paola@email.com>'
  end

end