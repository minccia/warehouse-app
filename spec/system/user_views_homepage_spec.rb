require 'rails_helper'

describe 'Usuário visita a página inicial' do 
  it 'e vê o nome da app' do 
    visit root_path 

    expect(page).to have_content('Galpões & Estoque')
  end
end