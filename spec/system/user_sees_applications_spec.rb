require 'rails_helper'

describe 'user sees applications' do
    it 'in own project show screen' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: '15/11/2021', user: user)
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: '10/11/2021', worker: worker, job: job)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'
        click_on 'Site de locação de imóveis'

        expect(page).not_to have_content('Envie sua proposta')
        expect(page).to have_content('Mauro T')
        expect(page).to have_content('Projetos ruby on rails')
        expect(page).to have_content('10/11/2021')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content('8 horas')
        expect(page).to have_content('Pendente')
    end

    it 'only after login' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: '15/11/2021', user: user)
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: '10/11/2021', worker: worker, job: job)
        
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'

        expect(page).not_to have_content('Envie sua proposta')
        expect(page).not_to have_content('Mauro T')
        expect(page).not_to have_content('Experiências: Projetos ruby on rails')
        expect(page).not_to have_content('Prazo de entrega estimado: 10/11/2021')
        expect(page).not_to have_content('Valor da hora trabalhada: R$ 25,00')
        expect(page).not_to have_content('Dedicação semanal: 8 horas')
    end

    it 'only for their own projects' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        esau = User.create!(email: 'esau@freelancers.com.br', password: '123456')
        jaco = User.create!(email: 'jaco@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: '15/11/2021', user: jaco)
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: '10/11/2021', worker: worker, job: job)
        
        login_as esau, scope: :user
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'

        expect(page).not_to have_content('Envie sua proposta')
        expect(page).not_to have_content('Mauro T')
        expect(page).not_to have_content('Experiências: Projetos ruby on rails')
        expect(page).not_to have_content('Prazo de entrega estimado: 10/11/2021')
        expect(page).not_to have_content('Valor da hora trabalhada: R$ 25,00')
        expect(page).not_to have_content('Dedicação semanal: 8 horas')
    end

    it 'and accepts application' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: '15/11/2021', user: user)
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: '10/11/2021', worker: worker, job: job)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'
        click_on 'Site de locação de imóveis'
        click_on 'Aceitar proposta'

        expect(current_path).to eq job_path(job)
        expect(page).not_to have_content('Envie sua proposta')
        expect(page).not_to have_content('Aceitar proposta')
        expect(page).to have_content('Mauro T')
        expect(page).to have_content('Projetos ruby on rails')
        expect(page).to have_content('10/11/2021')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content('8 horas')
        expect(page).to have_content('Aceita')
    end

    it 'and refuses application' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: '15/11/2021', user: user)
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: '10/11/2021', worker: worker, job: job)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'
        click_on 'Site de locação de imóveis'
        click_on 'Recusar proposta'

        expect(current_path).to eq job_path(job)
        expect(page).not_to have_content('Envie sua proposta')
        expect(page).not_to have_content('Recusar proposta')
        expect(page).to have_content('Mauro T')
        expect(page).to have_content('Projetos ruby on rails')
        expect(page).to have_content('10/11/2021')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content('8 horas')
        expect(page).to have_content('Recusada')
    end
end