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
end