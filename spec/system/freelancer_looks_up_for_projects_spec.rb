require 'rails_helper'

describe 'freelancer looks up for projects' do
    it 'in the project page' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 4.days.from_now, user: user)
        Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários comercializam livros',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 20, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).to have_link('Site de venda de livros')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content('Pagamento por hora: R$ 20,00')
        expect(page).to have_content(I18n.l(4.days.from_now.to_date))
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
    end
    
    it 'but there is no job available' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )

        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'

        expect(page).to have_content('Não há projetos disponíveis no momento.')
    end

    it 'and do not see unavailable ones' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 4.days.from_now, user: user)
        Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários comercializam livros',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 20, deadline: 5.days.from_now, user: user, status: 20)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).not_to have_link('Site de venda de livros')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).not_to have_content('Pagamento por hora: R$ 20,00')
        expect(page).to have_content(I18n.l(4.days.from_now.to_date))
        expect(page).not_to have_content(I18n.l(5.days.from_now.to_date))
    end

    it 'using search box' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 4.days.from_now, user: user)
        Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários comercializam livros',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 20, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        fill_in 'Busca:', with: 'imóveis'
        click_on 'Pesquisar'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).not_to have_link('Site de venda de livros')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).not_to have_content('Pagamento por hora: R$ 20,00')
        expect(page).to have_content(I18n.l(4.days.from_now.to_date))
        expect(page).not_to have_content(I18n.l(5.days.from_now.to_date))
    end

    it 'using search box but finds no answer' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 4.days.from_now, user: user)
        Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários comercializam livros',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 20, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        fill_in 'Busca:', with: 'carros'
        click_on 'Pesquisar'

        expect(page).not_to have_link('Site de locação de imóveis')
        expect(page).not_to have_link('Site de venda de livros')
        expect(page).not_to have_content('Pagamento por hora: R$ 25,00')
        expect(page).not_to have_content('Pagamento por hora: R$ 20,00')
        expect(page).not_to have_content(I18n.l(4.days.from_now.to_date))
        expect(page).not_to have_content(I18n.l(5.days.from_now.to_date))
        expect(page).to have_content('Não há projetos disponíveis no momento.')
    end

    it 'using search box but returns to complete list' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )
        user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
        Job.create!(title: 'Site de locação de imóveis',
                            description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 25, deadline: 4.days.from_now, user: user)
        Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários comercializam livros',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 20, deadline: 5.days.from_now, user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'
        fill_in 'Busca:', with: 'imóveis'
        click_on 'Pesquisar'
        click_on 'Ver todos os projeto'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).to have_link('Site de venda de livros')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content('Pagamento por hora: R$ 20,00')
        expect(page).to have_content(I18n.l(4.days.from_now.to_date))
        expect(page).to have_content(I18n.l(5.days.from_now.to_date))
        expect(page).not_to have_content('Não há projetos disponíveis no momento.')
    end
end