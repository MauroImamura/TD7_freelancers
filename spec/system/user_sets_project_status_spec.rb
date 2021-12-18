require 'rails_helper'

describe 'User sets project status' do
    it 'as executing' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'
        click_on 'Site de locação de imóveis'
        click_on 'Encerrar contratações'

        expect(current_path).to eq job_path(job)
        expect(page).not_to have_content('Envie sua proposta')
        expect(page).not_to have_content('Aceitar proposta')
        expect(page).to have_content('Site de locação de imóveis')
        expect(page).to have_content('Criar uma aplicação em que os usuários cadastram suas propriedades')
        expect(page).to have_content('Ruby on Rails: MVC, formulários, autenticação, sqlite3')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
        expect(page).to have_content('Executando')
    end

    it 'as finished' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user, status: 20)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'
        click_on 'Site de locação de imóveis'
        click_on 'Finalizar projeto'

        expect(current_path).to eq job_path(job)
        expect(page).not_to have_content('Envie sua proposta')
        expect(page).not_to have_content('Aceitar proposta')
        expect(page).to have_content('Site de locação de imóveis')
        expect(page).to have_content('Criar uma aplicação em que os usuários cadastram suas propriedades')
        expect(page).to have_content('Ruby on Rails: MVC, formulários, autenticação, sqlite3')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
        expect(page).to have_content('Finalizado')
    end
end