require 'rails_helper'

describe 'freelancer updates profile' do
    it 'through link on profile page' do
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
        click_on worker.email
        click_on 'Editar'

        expect(current_path).to eq edit_worker_path(worker)
    end
end