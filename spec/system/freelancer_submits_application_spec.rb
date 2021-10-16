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
                            payment: 25, deadline: '15/11/2021', user: user)
        
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
                            payment: 25, deadline: '15/11/2021', user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        click_on 'Site de locação de imóveis'
        fill_in 'Conte sua experiência sobre o assunto', with: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails'
        fill_in 'Valor por hora de trabalho', with: 25
        fill_in 'Horas de trabalho semanais', with: 8
        fill_in 'Previsão de entrega', with: '05/11/2021'
        click_on 'Enviar'

        expect(page).to have_content('Proposta enviada com sucesso')
        expect(page).to have_content('Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Rails')
        expect(page).to have_content('R$ 25,00')
        expect(page).to have_content('8 horas')
        expect(page).to have_content('05/11/2021')
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
                            payment: 25, deadline: '15/11/2021', user: user)
        
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
end