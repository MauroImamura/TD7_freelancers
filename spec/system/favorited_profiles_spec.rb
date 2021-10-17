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
        
        login_as user, scope: :user
        visit root_path
        click_on 'Encontre profissionais'
        click_on worker.social_name
        click_on 'Adicionar aos favoritos'

        expect(page).to have_content('Profissional adicionado aos favoritos')
    end

    it 'user can see favorited workers in the list' do
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
                                payment: 25, deadline: '15/11/2021', user: user, status: 30)
        favorited_worker = FavoritedWorker.create!(user: user, worker: worker1, checked: true)
        
        login_as user, scope: :user
        visit root_path
        click_on 'Encontre profissionais'

        expect(page).to have_content('Mauro T (favorito)')
        expect(page).not_to have_content('T Oruam (favorito)')
    end
end