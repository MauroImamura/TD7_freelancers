require 'rails_helper'

describe 'user sees feedbacks' do
    it 'through link in the top bar' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                                description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: '15/11/2021', user: user, status: 30)
        user_feedback = UserFeedback.create!(user: user, worker: worker, job: job, rate: 4, comment: 'Boa comunicação')

        login_as user, scope: :user
        visit root_path
        click_on user.email

        expect(page).to have_content('Boa comunicação')
        expect(page).to have_content('Nota 4')
    end

    it 'or the empty list message' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

        login_as user, scope: :user
        visit root_path
        click_on user.email

        expect(page).to have_content('Você ainda não possui feedbacks')
    end

    it 'through the link in job page' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                                description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: '15/11/2021', user: user, status: 30)
        user_feedback = UserFeedback.create!(user: user, worker: worker, job: job, rate: 4, comment: 'Boa comunicação')

        login_as user, scope: :user
        visit root_path
        click_on "Veja seus projetos"
        click_on job.title
        within 'dl' do
            click_on user.email
        end

        expect(page).to have_content('Boa comunicação')
        expect(page).to have_content('Nota 4')
    end

    it 'through job page even without login in' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job1 = Job.create!(title: 'Site de locação de imóveis',
                                description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: '15/11/2021', user: user, status: 30)
        job2 = Job.create!(title: 'Site de locação de veículos',
                                description: 'Criar uma aplicação em que os usuários cadastram seus veículos e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: '15/11/2021', user: user, status: 10)
        user_feedback = UserFeedback.create!(user: user, worker: worker, job: job1, rate: 4, comment: 'Boa comunicação')

        visit root_path
        click_on 'Encontre projetos'
        click_on job2.title
        within 'dl' do
            click_on user.email
        end

        expect(page).to have_content('Boa comunicação')
        expect(page).to have_content('Nota 4')
    end
end