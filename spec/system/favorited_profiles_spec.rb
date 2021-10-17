require 'rails_helper'

describe 'favorited profiles' do
    it 'workers selected by user' do
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
        click_on 'Encontre profissionais'
        click_on worker.social_name
        click_on 'Adicionar aos favoritos'

        expect(page).to have_content('Profissional adicionado aos favoritos')
    end
end