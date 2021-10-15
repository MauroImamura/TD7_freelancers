require 'rails_helper'

describe 'visitor visit home' do
    it 'successfully' do
        visit root_path

        expect(page).to have_content('Freelancers')
        expect(page).to have_content('Boas vindas ao sistema de contratação de freelancers')
        expect(page).to have_link('Início')
        expect(page).to have_link('Sou contratante')
        expect(page).to have_link('Sou freelancer')
    end
end