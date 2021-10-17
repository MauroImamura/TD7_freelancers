require 'rails_helper'

describe 'project recieves feedbacks' do
    context 'from user to freelancer' do
        it 'through project page' do
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
            Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: '12/11/2021', job: job, worker: worker, status: 10)
            
            login_as user, scope: :user
            visit root_path
            click_on 'Veja seus projetos'
            click_on 'Site de locação de imóveis'
            click_on worker.full_name

            expect(page).to have_content('Nota')
            expect(page).to have_content('Comentários')
        end

        it 'successfully' do
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
            Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: '12/11/2021', job: job, worker: worker, status: 10)
            
            login_as user, scope: :user
            visit root_path
            click_on 'Veja seus projetos'
            click_on 'Site de locação de imóveis'
            click_on worker.full_name
            fill_in 'Nota', with: 5
            fill_in 'Comentários', with: 'Bom'
            click_on 'Enviar'

            expect(page).to have_content('Feedback enviado com sucesso')
            expect(page).to have_content('Nota: 5')
            expect(page).to have_content('Comentários: Bom')
        end

        it 'and return to project page' do
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
            Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: '12/11/2021', job: job, worker: worker, status: 10)
            
            login_as user, scope: :user
            visit root_path
            click_on 'Veja seus projetos'
            click_on 'Site de locação de imóveis'
            click_on worker.full_name
            fill_in 'Nota', with: 5
            fill_in 'Comentários', with: 'Bom'
            click_on 'Enviar'
            click_on 'Voltar para projeto'

            expect(current_path).to eq job_path(job)
        end
    end

    context 'from freelancer to user' do
        it 'through project page' do
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
            Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: '12/11/2021', job: job, worker: worker, status: 10)
            
            login_as worker, scope: :worker
            visit root_path
            click_on 'Projetos que participo'
            click_on 'Site de locação de imóveis'
            click_on 'Avalie o contratante clicando aqui'

            expect(page).to have_content('Nota')
            expect(page).to have_content('Comentários')
        end

        it 'successfully' do
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
            Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: '12/11/2021', job: job, worker: worker, status: 10)
            
            login_as worker, scope: :worker
            visit root_path
            click_on 'Projetos que participo'
            click_on 'Site de locação de imóveis'
            click_on 'Avalie o contratante clicando aqui'
            fill_in 'Nota', with: 5
            fill_in 'Comentários', with: 'Bom'
            click_on 'Enviar'

            expect(page).to have_content('Feedback enviado com sucesso')
            expect(page).to have_content('Nota: 5')
            expect(page).to have_content('Comentários: Bom')
        end

        it 'and return to project page' do
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
            Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: '12/11/2021', job: job, worker: worker, status: 10)
            
            login_as worker, scope: :worker
            visit root_path
            click_on 'Projetos que participo'
            click_on 'Site de locação de imóveis'
            click_on 'Avalie o contratante clicando aqui'
            fill_in 'Nota', with: 5
            fill_in 'Comentários', with: 'Bom'
            click_on 'Enviar'
            click_on 'Voltar para projeto'

            expect(current_path).to eq job_path(job)
        end
    end
end