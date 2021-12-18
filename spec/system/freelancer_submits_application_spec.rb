require 'rails_helper'

describe 'freelancer submits application' do
    it 'on form in job page' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'

        expect(page).to have_content('Envie sua proposta')
        expect(page).to have_content('Conte sua experiência sobre o assunto')
        expect(page).to have_content('Valor por hora de trabalho')
        expect(page).to have_content('Horas de trabalho semanais')
        expect(page).to have_content('Previsão de entrega')
    end

    it 'successfully' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'
        fill_in 'Conte sua experiência sobre o assunto', with: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails'
        fill_in 'Valor por hora de trabalho', with: 25
        fill_in 'Horas de trabalho semanais', with: 8
        fill_in 'Previsão de entrega', with: 5.days.from_now
        click_on 'Enviar'

        expect(page).to have_content('Proposta enviada com sucesso')
        expect(page).to have_content('Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content('8 horas')
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
    end

    it 'without enough information' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'
        click_on 'Enviar'

        expect(page).to have_content('Conte sua experiência sobre o assunto não pode ficar em branco')
        expect(page).to have_content('Valor por hora de trabalho não pode ficar em branco')
        expect(page).to have_content('Horas de trabalho semanais não pode ficar em branco')
        expect(page).to have_content('Previsão de entrega não pode ficar em branco')
    end

    it 'only with complete profile' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456')
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'
        click_on 'completar perfil'

        expect(current_path).to eq edit_worker_path(worker)
        expect(page).not_to have_content('Envie sua proposta')
        expect(page).not_to have_content('Conte sua experiência sobre o assunto')
        expect(page).not_to have_content('Valor por hora de trabalho')
        expect(page).not_to have_content('Horas de trabalho semanais')
        expect(page).not_to have_content('Previsão de entrega')
    end

    it 'but decide to cancel it' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'
        fill_in 'Conte sua experiência sobre o assunto', with: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails'
        fill_in 'Valor por hora de trabalho', with: 25
        fill_in 'Horas de trabalho semanais', with: 8
        fill_in 'Previsão de entrega', with: 5.days.from_now
        click_on 'Enviar'
        click_on 'Voltar para projeto'
        click_on 'Clique aqui para cancelar'

        expect(page).to have_content('Proposta cancelada com sucesso')
    end

    it 'and re-send after canceling previews application' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'
        fill_in 'Conte sua experiência sobre o assunto', with: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails'
        fill_in 'Valor por hora de trabalho', with: 25
        fill_in 'Horas de trabalho semanais', with: 8
        fill_in 'Previsão de entrega', with: 5.days.from_now
        click_on 'Enviar'
        click_on 'Voltar para projeto'
        click_on 'Clique aqui para cancelar'
        fill_in 'Conte sua experiência sobre o assunto', with: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails'
        fill_in 'Valor por hora de trabalho', with: 25
        fill_in 'Horas de trabalho semanais', with: 8
        fill_in 'Previsão de entrega', with: 5.days.from_now
        click_on 'Enviar'

        expect(page).to have_content('Proposta enviada com sucesso')
        expect(page).to have_content('Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content('8 horas')
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
    end

    it 'and tries to send two applications and fails' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'
        fill_in 'Conte sua experiência sobre o assunto', with: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails'
        fill_in 'Valor por hora de trabalho', with: 25
        fill_in 'Horas de trabalho semanais', with: 8
        fill_in 'Previsão de entrega', with: 5.days.from_now
        click_on 'Enviar'
        click_on 'Voltar para projeto'
        fill_in 'Conte sua experiência sobre o assunto', with: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails'
        fill_in 'Valor por hora de trabalho', with: 25
        fill_in 'Horas de trabalho semanais', with: 8
        fill_in 'Previsão de entrega', with: 5.days.from_now
        click_on 'Enviar'

        expect(page).to have_content('Freelancer você já enviou uma proposta. Cancele a atual antes de mandar uma nova.')
    end
end