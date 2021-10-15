require 'rails_helper'

describe 'User register job' do
    it 'sucessfully' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

        login_as user, scope: :user
        visit root_path
        click_on 'Cadastre um projeto'
        fill_in 'Título', with: 'Site de locação de imóveis'
        fill_in 'Descrição', with: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado'
        fill_in 'Habilidades', with: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3'
        fill_in 'Pagamento por hora', with: 25
        fill_in 'Data limite', with: '15/11/2021'
        click_on 'Enviar'

        expect(page).to have_content('Site de locação de imóveis')
        expect(page).to have_content('Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado')
        expect(page).to have_content('Ruby on Rails: MVC, formulários, autenticação, sqlite3')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content('15/11/2021')
        expect(page).to have_content('remoto')
        expect(page).to have_content('Projeto cadastrado com sucesso!')
    end
end