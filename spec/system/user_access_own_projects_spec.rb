require 'rails_helper'

describe 'user access own projects' do
    it 'using menu' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

        login_as user, scope: :user
        visit root_path

        expect(page).to have_link('Veja seus projetos')
    end

    it 'but the list is empty' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'

        expect(page).to have_content('Você ainda não possui projetos cadastrados')
        expect(page).to have_link('Cadastre um projeto')
    end

    it 'sucessfully' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)

        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
    end

    it 'and do not see other projects' do
        isaac = User.create!(email: 'isaac@freelancers.com.br', password: '123456')
        ismael = User.create!(email: 'ismael@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: isaac)
        job = Job.create!(title: 'Site de locação de propriedades',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 30, deadline: 5.days.from_now, user: ismael)
        
        login_as isaac, scope: :user
        visit root_path
        click_on 'Veja seus projetos'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
        expect(page).not_to have_content('Site de locação de propriedades')
    end

    it 'and sees approved freelancers list' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        worker1 = Worker.create!(email: 'worker1@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                            social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                            experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                            birth_date: '18/11/1994'
                            )
        worker2 = Worker.create!(email: 'worker2@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                            social_name: 'T Oruam', description: 'dev', education: 'superior completo',
                            experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                            birth_date: '18/11/1994'
                            )
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: 5.days.from_now, worker: worker1, job: job, status: 10)
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: 5.days.from_now, worker: worker2, job: job, status: 0)

        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'
        click_on 'Site de locação de imóveis'

        expect(page).to have_css('div#team_list', text: worker1.social_name)
        expect(page).not_to have_css('div#team_list', text: worker2.social_name)
        expect(page).to have_content('Veja o time de profissionais')
    end

    it 'and clicks on approved freelancers list' do
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        job = Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        worker1 = Worker.create!(email: 'worker1@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                            social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                            experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                            birth_date: '18/11/1994'
                            )
        worker2 = Worker.create!(email: 'worker2@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                            social_name: 'T Oruam', description: 'dev', education: 'superior completo',
                            experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                            birth_date: '18/11/1994'
                            )
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: 5.days.from_now, worker: worker1, job: job, status: 10)
        Application.create!(description: 'Projetos ruby on rails', payment: 25, time_per_week: 8,
                            expected_deadline: 5.days.from_now, worker: worker2, job: job, status: 0)

        login_as user, scope: :user
        visit root_path
        click_on 'Veja seus projetos'
        click_on 'Site de locação de imóveis'
        within('div#team_list') do
            click_on worker1.social_name
        end

        expect(page).to have_content(worker1.social_name)
        expect(page).to have_content(worker1.full_name)
        expect(page).to have_content(worker1.description)
        expect(page).to have_content(worker1.education)
        expect(page).to have_content(worker1.birth_date)
        expect(page).to have_content(worker1.experience)
    end
end