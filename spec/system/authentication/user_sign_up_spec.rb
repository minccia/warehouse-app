require 'rails_helper'

describe 'Usuário faz um cadastro' do
  it 'com sucesso' do 
    visit root_path 
    click_on 'Fazer Login'
    click_on 'Inscrever-se'

    within 'form' do 
      fill_in 'Nome', with: 'Paola Dobrotto'
      fill_in 'Email', with: 'paolitas@gmail.com'
      fill_in 'Senha', with: '32823144'
      fill_in 'Confirme sua senha', with: '32823144'
      click_on 'Inscrever-se'
    end
    
    expect(page).to have_content 'Olá, Paola Dobrotto'
    expect(page).to have_button 'Sair'
    expect(page).to have_content 'Bem vindo! Você realizou seu registro com sucesso'
    expect(User.last.name).to eq 'Paola Dobrotto'
  end

end