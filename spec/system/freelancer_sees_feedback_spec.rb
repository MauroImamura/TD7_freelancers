require 'rails_helper'

describe 'freelancer sees feedback' do
    it 'through their profile' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                                description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: 5.days.from_now, user: user, status: 30)
        appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: 5.days.from_now, job: job, worker: worker, status: 10)
        worker_feedback = WorkerFeedback.create!(user: user, worker: worker, application: appl, rate: 4, comment: 'Bom conhecimento técnico')

        login_as worker, scope: :worker
        visit root_path
        click_on worker.email
        click_on 'Lista de feedbacks'

        expect(page).to have_content('Bom conhecimento técnico')
        expect(page).to have_content('Nota 4')
    end

    it 'or message that there is no feedback yet' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                                description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: 5.days.from_now, user: user, status: 30)
        appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: 5.days.from_now, job: job, worker: worker, status: 10)

        login_as worker, scope: :worker
        visit root_path
        click_on worker.email
        click_on 'Lista de feedbacks'

        expect(page).to have_content('Você ainda não possui feedbacks')
    end

    it 'without being logged' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                                description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: 5.days.from_now, user: user, status: 30)
        appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: 5.days.from_now, job: job, worker: worker, status: 10)
        worker_feedback = WorkerFeedback.create!(user: user, worker: worker, application: appl, rate: 4, comment: 'Bom conhecimento técnico')

        visit root_path
        click_on 'Encontre profissionais'
        click_on worker.social_name
        click_on 'Lista de feedbacks'

        expect(page).to have_content(worker.social_name)
        expect(page).to have_content('Bom conhecimento técnico')
        expect(page).to have_content('Nota 4')
    end
end