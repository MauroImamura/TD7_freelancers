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
    end

    context 'as worker' do
        it 'to create application' do
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
            Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários comercializam livros',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 20, deadline: '25/11/2021', user: user)
            post '/jobs/1/applications'
        
            expect(response).to redirect_to(new_worker_session_path)
        end
    end
end