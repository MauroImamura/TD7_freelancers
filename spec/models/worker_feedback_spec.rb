require 'rails_helper'

describe WorkerFeedback do
    context 'validation' do
        context 'presence' do
            it 'rate must be present' do              
                worker_feedback = WorkerFeedback.new
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:rate)).to include('Nota não pode ficar em branco')
            end
            it 'comment must be present' do
                worker_feedback = WorkerFeedback.new
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:comment)).to include('Comentários não pode ficar em branco')
            end
            it 'user must be present' do
                worker_feedback = WorkerFeedback.new
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:user)).to include('Contratante é obrigatório(a)')
            end
        end

        context 'numericality' do
            it 'rate must be greater than or equals to zero' do
                worker_feedback = WorkerFeedback.new(rate: -1)
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:rate)).to include('Nota deve ser maior ou igual a 0')
            end
            it 'rate must be greater than or equals to zero' do
                worker_feedback = WorkerFeedback.new(rate: 0)
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:rate)).to eq []
            end
            it 'rate must be less than or equals to five' do
                worker_feedback = WorkerFeedback.new(rate: 6)
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:rate)).to include('Nota deve ser menor ou igual a 5')
            end
            it 'rate must be less than or equals to five' do
                worker_feedback = WorkerFeedback.new(rate: 5)
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:rate)).to eq []
            end
        end

        context 'text length' do
            it 'comment has more than 100 characters' do
                worker_feedback = WorkerFeedback.new(comment: 'Bommmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm')
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:comment)).to include('Comentários é muito longo (máximo: 100 caracteres)')
            end
            it 'comment has up to 100 characters' do
                worker_feedback = WorkerFeedback.new(comment: 'Bommmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm')
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:comment)).to eq []
            end
        end

        context 'uniqueness' do
            it 'only one feedback per user per application' do
                worker = Worker.create!(email: 'worker@freelancers.com.br', password: '123456', full_name: 'Mauro T',
                                    social_name: 'Mauro T', description: 'dev', education: 'superior completo',
                                    experience: 'aplicações web em rails (portifólio: https://github.com/MauroImamura)',
                                    birth_date: '18/11/1994'
                                    )
                user = User.create!(email: 'usuario@freelancers.com.br', password: '123456')
                job = Job.create!(title: 'Site de locação de imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: 20.days.from_now , user: user, status: 30)
                appl = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker, status: 10)
                WorkerFeedback.create!(user: user, worker: worker, application: appl, rate: 5, comment: 'Bom conhecimento técnico')
                worker_feedback = WorkerFeedback.create(user: user, worker: worker, application: appl, rate: 4, comment: 'Agilidade nas tarefas')
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:user)).to include("Contratante você já enviou um feedback para esta aplicação.")
            end

            it 'accepts feedbacks to different worker' do
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
                                    payment: 25, deadline: 20.days.from_now , user: user, status: 30)
                appl1 = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker1, status: 10)
                appl2 = Application.create!(description: '3 anos de experiência', payment: 30, time_per_week: 8,
                                    expected_deadline: 20.days.from_now , job: job, worker: worker2, status: 10)
                WorkerFeedback.create!(user: user, worker: worker1, application: appl1, rate: 5, comment: 'Bom conhecimento técnico')
                worker_feedback = WorkerFeedback.create(user: user, worker: worker2, application: appl2, rate: 4, comment: 'Agilidade nas tarefas')
                worker_feedback.valid?
                expect(worker_feedback.errors.full_messages_for(:user)).to eq([])
            end
        end
    end
end
