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
                            payment: 25, deadline: '15/11/2021', user: user)
        Job.create!(title: 'Site de venda de livros',
                            description: 'Criar uma aplicação em que os usuários comercializam livros',
                            skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                            payment: 20, deadline: '25/11/2021', user: user)
        
        login_as worker, scope: :worker
        visit root_path
        click_on 'Encontre projetos'

        expect(page).to have_link('Site de locação de imóveis')
        expect(page).to have_link('Site de venda de livros')
        expect(page).to have_content('Pagamento por hora: R$ 25,00')
        expect(page).to have_content('Pagamento por hora: R$ 20,00')
        expect(page).to have_content('15/11/2021')
        expect(page).to have_content('25/11/2021')
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
end