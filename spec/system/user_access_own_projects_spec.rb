require 'rails_helper'

describe 'user access own projects' do
    it 'using menu' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

        login_as user, scope: :user
        visit root_path

        expect(page).to have_link('Veja seus projetos')
    end
    it 'but the list is empty' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'

        expect(page).to have_content('Você ainda não possui projetos cadastrados')
        expect(page).to have_link('Cadastre um projeto')
    end
    it 'sucessfully' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: '15/11/2021', user: user)

        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content('15/11/2021')
    end
    it 'and do not see other projects' do
        isaac = User.create!(email: 'isaac@freelancers.com.br', password: '123456')
        ismael = User.create!(email: 'ismael@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: '15/11/2021', user: isaac)
        job = Job.create!(title: 'Site de locação de propriedades',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 30, deadline: '05/11/2021', user: ismael)
        
        login_as isaac, scope: :user
        visit root_path
        click_on 'Veja seus projetos'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content('15/11/2021')
        expect(page).not_to have_content('Site de locação de propriedades')
    end
end