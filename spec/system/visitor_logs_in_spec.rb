require 'rails_helper'

describe 'visitor logs in' do
    context 'as user' do
        it 'successfully' do
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

            visit root_path
            click_on 'Sou contratante'
            fill_in 'Email', with: user.email
            fill_in 'Senha', with: user.password
            click_on 'Entrar'

            expect(page).to have_content('Login efetuado com sucesso')
            expect(page).to have_content(user.email)
            expect(page).to have_link('Sair')
            expect(page).not_to have_content('Sou usuário')
            expect(page).not_to have_content('Sou freelancer')
        end

        it 'and logs out' do
            user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')

            visit root_path
            click_on 'Sou contratante'
            fill_in 'Email', with: user.email
            fill_in 'Senha', with: user.password
            click_on 'Entrar'
            click_on 'Sair'

            expect(page).to have_link('Sou contratante')
            expect(page).to have_link('Sou freelancer')
            expect(page).not_to have_content(user.email)
            expect(page).not_to have_content('Sair')
        end

        it 'goes to login page but return to home' do
            visit root_path
            click_on 'Sou contratante'
            click_on 'Início'

            expect(current_path).to eq root_path
        end
    end

    context 'as freelancer' do
        it 'successfully' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456')

            visit root_path
            click_on 'Sou freelancer'
            fill_in 'Email', with: worker.email
            fill_in 'Senha', with: worker.password
            click_on 'Entrar'

            expect(page).to have_content('Login efetuado com sucesso')
            expect(page).to have_content(worker.email)
            expect(page).to have_link('Sair')
            expect(page).not_to have_content('Sou usuário')
            expect(page).not_to have_content('Sou freelancer')
        end

        it 'and logs out' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456')

            visit root_path
            click_on 'Sou freelancer'
            fill_in 'Email', with: worker.email
            fill_in 'Senha', with: worker.password
            click_on 'Entrar'
            click_on 'Sair'

            expect(page).to have_link('Sou contratante')
            expect(page).to have_link('Sou freelancer')
            expect(page).not_to have_content(worker.email)
            expect(page).not_to have_content('Sair')
        end

        it 'goes to login page but return to home' do
            visit root_path
            click_on 'Sou freelancer'
            click_on 'Início'

            expect(current_path).to eq root_path
        end

        it 'successfully and completes profile' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456')

            visit root_path
            click_on 'Sou freelancer'
            fill_in 'Email', with: worker.email
            fill_in 'Senha', with: worker.password
            click_on 'Entrar'
            fill_in 'Nome completo', with: 'João filho de Zebedeu'
            fill_in 'Nome social', with: 'João filho de Zebedeu'
            fill_in 'Sobre você', with: 'dev'
            fill_in 'Formação', with: 'superior'
            fill_in 'Data de nascimento', with: '11/11/1111'
            fill_in 'Experiência', with: '50 anos de mercado'
            click_on 'Enviar'

            expect(page).to have_content('João filho de Zebedeu')
            expect(page).to have_content('dev')
            expect(page).to have_content('superior')
            expect(page).to have_content('11/11/1111')
            expect(page).to have_content('50 anos de mercado')
        end

        it 'successfully and has already completed profile' do
            worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456',description: 'dev',
                                    full_name: 'João filho de Zebedeu', social_name: 'João filho de Zebedeu',
                                    education: 'superior completo',
                                    experience: 'aplicações web em rails',
                                    birth_date: '11/11/1111')

            visit root_path
            click_on 'Sou freelancer'
            fill_in 'Email', with: worker.email
            fill_in 'Senha', with: worker.password
            click_on 'Entrar'
            click_on 'Enviar'

            expect(page).to have_content('João filho de Zebedeu')
            expect(page).to have_content('dev')
            expect(page).to have_content('superior completo')
            expect(page).to have_content('11/11/1111')
            expect(page).to have_content('aplicações web em rails')
        end
    end
end