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
    end
end