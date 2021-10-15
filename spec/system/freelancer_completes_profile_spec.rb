require 'rails_helper'

describe 'freelancer sees profile' do
    it 'as long as they logged previously' do
        worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                birth_date: '18/11/1994'
                                )

        login_as worker, scope: :worker
        visit root_path
        click_on worker.email

        expect(page).to have_content('Nome completo')
        expect(page).to have_content('Nome social')
        expect(page).to have_content('Data de nascimento')
        expect(page).to have_content('Formação')
        expect(page).to have_content('Descrição')
        expect(page).to have_content('Experiência')
    end
end