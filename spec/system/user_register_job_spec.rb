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
        fill_in 'Data limite', with: 5.days.from_now
        click_on 'Enviar'

        expect(page).to have_content('Site de locação de imóveis')
        expect(page).to have_content('Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado')
        expect(page).to have_content('Ruby on Rails: MVC, formulários, autenticação, sqlite3')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
        expect(page).to have_content('remoto')
        expect(page).to have_content('Projeto cadastrado com sucesso!')
    end

    it 'and do not succed on empty spaces' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

        login_as user, scope: :user
        visit root_path
        click_on 'Cadastre um projeto'
        click_on 'Enviar'

        expect(page).to have_content('Título não pode ficar em branco')
        expect(page).to have_content('Descrição não pode ficar em branco')
        expect(page).to have_content('Habilidades não pode ficar em branco')
        expect(page).to have_content('Pagamento por hora não pode ficar em branco')
        expect(page).to have_content('Data limite não pode ficar em branco')
    end
end