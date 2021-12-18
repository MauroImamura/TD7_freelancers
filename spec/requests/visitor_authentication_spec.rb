require 'rails_helper'

describe 'visitor authentication' do
    context 'as user' do
        it 'to create a job' do
            post '/jobs'

            expect(response).to redirect_to(new_user_session_path)
        end

        it 'to acccess new job form' do
            get '/jobs/new'
            
            expect(response).to redirect_to(new_user_session_path)
        end

        it 'to accept job applications' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                    birth_date: '18/11/1994'
                    )
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user, status: 10)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                    expected_deadline: 18.days.from_now, job: job, worker: worker, status: 5)
            
            post '/applications/1/accept'

            expect(response).to redirect_to(new_user_session_path)
        end

        it 'to refuse job applications' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                    birth_date: '18/11/1994'
                    )
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user, status: 10)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                    expected_deadline: 18.days.from_now, job: job, worker: worker, status: 5)
            
            post '/applications/1/refuse'

            expect(response).to redirect_to(new_user_session_path)
        end

        it 'to see job list' do
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user, status: 10)
            
            get '/jobs/my_jobs'

            expect(response).to redirect_to(new_user_session_path)
        end

        it 'to set worker as favorite' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                    birth_date: '18/11/1994'
                    )
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user, status: 10)
            
            post '/workers/1/favorited_workers/1/add'

            expect(response).to redirect_to(new_user_session_path)
        end

        it 'to send to worker a feedback' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                    birth_date: '18/11/1994'
                    )
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user, status: 30)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                    expected_deadline: 18.days.from_now, job: job, worker: worker, status: 10)
            
            post '/applications/1/worker_feedbacks'

            expect(response).to redirect_to(new_user_session_path)
        end

        it 'to access feedback form' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                    birth_date: '18/11/1994'
                    )
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user, status: 30)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                    expected_deadline: 18.days.from_now, job: job, worker: worker, status: 10)
            
            get '/applications/1/worker_feedbacks/new'

            expect(response).to redirect_to(new_user_session_path)
        end

        it 'to change job status to executing' do
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user, status: 10)
    
            post '/jobs/1/finish_hiring'

            expect(job.status).to eq("hiring")
        end

        it 'to change job status to finished' do
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user, status: 10)
    
            post '/jobs/:id/finish_project'

            expect(job.status).to eq("hiring")
        end
    end

    context 'as correct user' do
        it 'to accept job applications' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                    birth_date: '18/11/1994'
                    )
            user1 = User.create!(email: 'usuario1@freelancers.com.br', password: '123456')
            user2 = User.create!(email: 'usuario2@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user1, status: 10)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                    expected_deadline: 18.days.from_now, job: job, worker: worker, status: 5)
            
            login_as user2, scope: :user
            post '/applications/1/accept'

            expect(appl.status).to eq("pending")
        end

        it 'to refuse job applications' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                    birth_date: '18/11/1994'
                    )
            user1 = User.create!(email: 'usuario1@freelancers.com.br', password: '123456')
            user2 = User.create!(email: 'usuario2@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user1, status: 10)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                    expected_deadline: 18.days.from_now, job: job, worker: worker, status: 5)
            
            login_as user2, scope: :user
            post '/applications/1/refuse'

            expect(appl.status).to eq("pending")
        end

        it 'to access feedback form' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                    birth_date: '18/11/1994'
                    )
            user1 = User.create!(email: 'usuario1@freelancers.com.br', password: '123456')
            user2 = User.create!(email: 'usuario2@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user1, status: 30)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                    expected_deadline: 18.days.from_now, job: job, worker: worker, status: 10)
            
            login_as user2, scope: :user
            get '/applications/1/worker_feedbacks/new'

            expect(response).not_to redirect_to(new_application_worker_feedback_path)
        end

        it 'to change job status to executing' do
            user1 = User.create!(email: 'usuario1@freelancers.com.br', password: '123456')
            user2 = User.create!(email: 'usuario2@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user1, status: 10)
    
            login_as user2, scope: :user
            post '/jobs/1/finish_hiring'

            expect(job.status).to eq("hiring")
        end

        it 'to change job status to finished' do
            user1 = User.create!(email: 'usuario1@freelancers.com.br', password: '123456')
            user2 = User.create!(email: 'usuario2@freelancers.com.br', password: '123456')
            job = Job.create!(title: 'Site de locação de imóveis',
                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                    payment: 25, deadline: 20.days.from_now, user: user1, status: 10)
    
            login_as user2, scope: :user
            post '/jobs/1/finish_project'

            expect(job.status).to eq("hiring")
        end
    end

    context 'as worker' do
        it 'to create application' do
            post '/jobs/1/applications'
        
            expect(response).to redirect_to(new_worker_session_path)
        end

        it 'to see own profile' do
            get '/my_profile'
        
            expect(response).to redirect_to(new_worker_session_path)
        end

        it 'to edit profile' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )

            get '/workers/1/edit'
        
            expect(response).to redirect_to(new_worker_session_path)
        end

        it 'to see own job list' do
            get '/jobs/accepted_jobs'
        
            expect(response).to redirect_to(new_worker_session_path)
        end

        it 'to send user feedback' do
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
            
            post '/jobs/1/user_feedbacks'

            expect(response).to redirect_to(new_worker_session_path)
        end
    end

    context 'as correct worker' do
        it 'to cancel job application' do
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
            job = Job.create!(title: 'Site de locação de imóveis',
                                description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: 5.days.from_now, user: user)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: 5.days.from_now, job: job, worker: worker1, status: 5)

            login_as worker2, scope: :worker
            post '/applications/1/cancel'

            expect(appl.status).to eq("pending")
        end

        it 'to send user feedback' do
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
            job = Job.create!(title: 'Site de locação de imóveis',
                                description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                payment: 25, deadline: 5.days.from_now, user: user, status: 30)
            appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                expected_deadline: 5.days.from_now, job: job, worker: worker1, status: 10)

            login_as worker2, scope: :worker
            get '/jobs/1/user_feedbacks/new'

            expect(response).not_to redirect_to(new_job_user_feedback_path)
        end
    end
end