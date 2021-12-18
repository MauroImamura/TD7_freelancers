require 'rails_helper'

describe 'user looks up for worker' do
    it 'through home link' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Encontre profissionais'

        expect(page).to have_link(worker.social_name)
        expect(page).to have_content(worker.description)
        expect(page).to have_content(worker.email)
    end

    it 'and click for details' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Encontre profissionais'
        click_on worker.social_name

        expect(page).to have_content(worker.social_name)
        expect(page).to have_content(worker.description)
        expect(page).to have_content(worker.education)
        expect(page).to have_content(worker.experience)
        expect(page).to have_content(worker.birth_date)
        expect(page).to have_content(worker.email)
    end

    it 'and do not see invalid profiles' do
        worker_complete = Worker.create!(email: 'worker1@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        worker_incomplete = Worker.create(email: 'worker2@freelancers.com.br', password: '123456'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Encontre profissionais'

        expect(page).to have_link(worker_complete.social_name)
        expect(page).to have_content(worker_complete.description)
        expect(page).to have_content(worker_complete.email)
        expect(page).not_to have_content(worker_incomplete.email)
    end

    it 'but the list is empty' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Encontre profissionais'

        expect(page).to have_content('Ainda não há profissionais listados')
        expect(page).not_to have_content('Nome')
        expect(page).not_to have_content('Descrição')
        expect(page).not_to have_content('Contato')
    end
end