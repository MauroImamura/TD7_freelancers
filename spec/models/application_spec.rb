require 'rails_helper'

describe Application do
    context 'validation' do
        context 'present' do
            it 'description must be present' do
                application = Application.new
                application.valid?
                expect(application.errors.full_messages_for(:description)).to include('Conte sua experiência sobre o assunto não pode ficar em branco')
            end
            it 'payment must be present' do
                application = Application.new
                application.valid?
                expect(application.errors.full_messages_for(:payment)).to include('Valor por hora de trabalho não pode ficar em branco')
            end
            it 'time_per_week must be present' do
                application = Application.new
                application.valid?
                expect(application.errors.full_messages_for(:time_per_week)).to include('Horas de trabalho semanais não pode ficar em branco')
            end
            it 'expected_deadline must be present' do
                application = Application.new
                application.valid?
                expect(application.errors.full_messages_for(:expected_deadline)).to include('Previsão de entrega não pode ficar em branco')
            end
        end

        context 'length' do
            it 'description above maximum length' do
                application = Application.new(description: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Railssssssssssssssssssssssssssss')
                application.valid?
                expect(application.errors.full_messages_for(:description)).to include('Conte sua experiência sobre o assunto é muito longo (máximo: 100 caracteres)')
            end
            it 'description has maximum length' do
                application = Application.new(description: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Railsssssssssssssssssssssssssss')
                application.valid?
                expect(application.errors.full_messages_for(:description)).to eq([])
            end
            it 'description bellow maximum length' do
                application = Application.new(description: 'Já participei de 3 projetos de desenvolvimento de aplicações Ruby on Railssssssssssssssssssssssssss')
                application.valid?
                expect(application.errors.full_messages_for(:description)).to eq([])
            end
        end

        context 'numerically' do
            it 'payment is a number' do
                application = Application.new(payment: 1)
                application.valid?
                expect(application.errors.full_messages_for(:payment)).to eq([])
            end
            it 'payment is not a number' do
                application = Application.new(payment: 'um')
                application.valid?
                expect(application.errors.full_messages_for(:payment)).to include('Valor por hora de trabalho não é um número')
            end
            it 'payment is greater than zero' do
                application = Application.new(payment: 1)
                application.valid?
                expect(application.errors.full_messages_for(:payment)).to eq([])
            end
            it 'payment is equals to zero' do
                application = Application.new(payment: 0)
                application.valid?
                expect(application.errors.full_messages_for(:payment)).to include('Valor por hora de trabalho deve ser maior que 0')
            end
            it 'payment is less than zero' do
                application = Application.new(payment: -1)
                application.valid?
                expect(application.errors.full_messages_for(:payment)).to include('Valor por hora de trabalho deve ser maior que 0')
            end
        end

        context 'expected deadline is feasible' do
            it 'date is greater than current date' do
                application = Application.new(expected_deadline: 1.days.from_now)
                application.valid?
                expect(application.errors.full_messages_for(:expected_deadline)).to eq([])
            end
            it 'date is equals to current date' do
                application = Application.new(expected_deadline: Date.today)
                application.valid?
                expect(application.errors.full_messages_for(:expected_deadline)).to include('Previsão de entrega inválida, escolha uma data a partir de hoje.')
            end
            it 'date is before the current date' do
                application = Application.new(expected_deadline: 2.days.ago)
                application.valid?
                expect(application.errors.full_messages_for(:expected_deadline)).to include('Previsão de entrega inválida, escolha uma data a partir de hoje.')
            end
        end

        context 'uniqueness' do
            it 'only one application per worker per job' do
                worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
                user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
                job = Job.create!(title: 'Site de locação de imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: 20.days.from_now , user: user, status: 10)
                Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker)
                application = Application.create(description: '3 anos de experiência', payment: 40, time_per_week: 10,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker)
                application.valid?
                expect(application.errors.full_messages_for(:worker)).to include("Freelancer você já enviou uma proposta. Cancele a atual antes de mandar uma nova.")
            end

            it 'only one application per worker per job even after being refused' do
                worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
                user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
                job = Job.create!(title: 'Site de locação de imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: 20.days.from_now , user: user, status: 10)
                Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker, status: 0)
                application = Application.create(description: '3 anos de experiência', payment: 40, time_per_week: 10,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker)
                application.valid?
                expect(application.errors.full_messages_for(:worker)).to include("Freelancer você já enviou uma proposta. Cancele a atual antes de mandar uma nova.")
            end

            it 'accept applications from different workers' do
                worker1 = Worker.create!(email: 'worker1@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
                worker2 = Worker.create!(email: 'worker2@freelancers.com.br', password: '123456', full_name: 'T Oruam',
                                    social_name: 'T Oruam', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
                user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
                job = Job.create!(title: 'Site de locação de imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: 20.days.from_now , user: user, status: 10)
                Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker1)
                application = Application.create(description: '3 anos de experiência', payment: 40, time_per_week: 10,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker2)
                application.valid?
                expect(application.errors.full_messages_for(:worker)).to eq([])
            end

            #TODO: teste para verificar envio de proposta após uma ser cancelada
        end
    end
end
