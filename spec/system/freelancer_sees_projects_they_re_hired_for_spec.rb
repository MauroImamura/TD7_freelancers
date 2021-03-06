require 'rails_helper'

describe 'freelancer sees project they`re hired for' do
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
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job, worker: worker, status: 10)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Projetos que participo'

        expect(page).to have_link('Site de locação de imóveis')
    end

    it 'but the list is empty' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Projetos que participo'

        expect(page).to have_content('Você ainda não possui projetos em sua lista')
    end

    it 'and do not see the ones they`ve not been accepted' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job1 = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        job2 = Job.create!(title: 'Site de locação de veículos',
                            description: 'Criar uma aplicação em que os usuários cadastram seus veículos e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        job3 = Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários cadastram seus livros e disponibilizam para venda',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job1, worker: worker, status: 10)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job2, worker: worker, status: 0)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job3, worker: worker, status: 5)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Projetos que participo'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).not_to have_content('Site de locação de veículos')
        expect(page).not_to have_content('Site de venda de livros')
    end

    it 'and do not see info from other workers' do
        worker1 = Worker.create!(email: 'worker1@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        worker2 = Worker.create!(email: 'worker2@freelancers.com.br', password: '123456', full_name: 'T Oruam',
                                social_name: 'T Oruam', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job1 = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        job2 = Job.create!(title: 'Site de locação de veículos',
                            description: 'Criar uma aplicação em que os usuários cadastram seus veículos e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        job3 = Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários cadastram seus livros e disponibilizam para venda',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job1, worker: worker1, status: 10)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job2, worker: worker1, status: 10)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job3, worker: worker2, status: 10)
        
        login_as worker1, scope: :worker
        visit root_path
        click_on 'Projetos que participo'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).to have_content('Site de locação de veículos')
        expect(page).not_to have_content('Site de venda de livros')
    end

    it 'and sees people they will work with' do
        worker1 = Worker.create!(email: 'worker1@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        worker2 = Worker.create!(email: 'worker2@freelancers.com.br', password: '123456', full_name: 'T Oruam',
                                social_name: 'T Oruam', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job1 = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job1, worker: worker1, status: 10)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job1, worker: worker2, status: 10)
        
        login_as worker1, scope: :worker
        visit root_path
        click_on 'Projetos que participo'
        click_on 'Site de locação de imóveis'

        expect(page).to have_css('div#team_list', text: worker1.social_name)
        expect(page).to have_css('div#team_list', text: worker2.social_name)
    end

    it 'and does not see people in projects they are not approved' do
        worker1 = Worker.create!(email: 'worker1@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        worker2 = Worker.create!(email: 'worker2@freelancers.com.br', password: '123456', full_name: 'T Oruam',
                                social_name: 'T Oruam', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job1 = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job1, worker: worker1, status: 0)
        Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                            expected_deadline: 5.days.from_now, job: job1, worker: worker2, status: 10)
        
        login_as worker1, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'

        expect(page).not_to have_css('div#team_list', text: worker1.social_name)
        expect(page).not_to have_css('div#team_list', text: worker2.social_name)
    end
end