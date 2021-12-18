require 'rails_helper'

describe Job do
    context 'validations' do
        context 'present' do
            it 'title must be present' do
                job = Job.new
                job.valid?
                expect(job.errors.full_messages_for(:title)).to include('Título não pode ficar em branco')                
            end
            it 'description must be present' do
                job = Job.new
                job.valid?
                expect(job.errors.full_messages_for(:description)).to include('Descrição não pode ficar em branco')                
            end
            it 'skills must be present' do
                job = Job.new
                job.valid?
                expect(job.errors.full_messages_for(:skills)).to include('Habilidades não pode ficar em branco')                
            end
            it 'payment must be present' do
                job = Job.new
                job.valid?
                expect(job.errors.full_messages_for(:payment)).to include('Pagamento por hora não pode ficar em branco')                
            end
            it 'deadline must be present' do
                job = Job.new
                job.valid?
                expect(job.errors.full_messages_for(:deadline)).to include('Data limite não pode ficar em branco')                
            end
        end

        context 'unique' do
            it 'title must be unique' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                Job.create!(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: 5.days.from_now, user: user)
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: 5.days.from_now, user: user)
                job.valid?
                expect(job.errors.full_messages_for(:title)).to include('Título já está em uso')
            end
        end

        context 'length' do
            it 'title above maximum length' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveisssssssssssssssssssssssssss',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:title)).to include('Título é muito longo (máximo: 50 caracteres)')
            end
            it 'title equal to maximum length' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveissssssssssssssssssssssssss',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:title)).to eq([])
            end
            it 'description above maximum length' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinadooooo',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:description)).to include('Descrição é muito longo (máximo: 120 caracteres)')
            end
            it 'description equal to maximum length' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinadoooo',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:description)).to eq([])
            end
        end

        context 'numericality' do
            it 'payment is a number' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:payment)).to eq([])
            end
            it 'payment is not a number' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 'vinte e cinco', deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:payment)).to include('Pagamento por hora não é um número')
            end
            it 'payment is greater than zero' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 1, deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:payment)).to eq([])
            end
            it 'payment is zero' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 0, deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:payment)).to include('Pagamento por hora deve ser maior que 0')
            end
            it 'payment is negative' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: -1, deadline: '15/11/2021', user: user)
                job.valid?
                expect(job.errors.full_messages_for(:payment)).to include('Pagamento por hora deve ser maior que 0')
            end
        end

        context 'date is feasible' do
            it 'deadline is greater than current date' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: 1.days.from_now, user: user)
                job.valid?
                expect(job.errors.full_messages_for(:deadline)).to eq([])
            end
            it 'deadline is the current date' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: Date.today, user: user)
                job.valid?
                expect(job.errors.full_messages_for(:deadline)).to include('Data limite inválida, escolha uma data a partir de hoje.')
            end
            it 'deadline is before the current date' do
                user = User.create!(email: 'usuario@freelancers.com', password: '123456')
                job = Job.new(title: 'site de locação e imóveis',
                                    description: 'Criar uma aplicação em que os usuários cadastram suas propriedades e disponibilizam para alugar por tempo determinado',
                                    skills: 'Ruby on Rails: MVC, formulários, autenticação, sqlite3',
                                    payment: 25, deadline: 2.days.ago, user: user)
                job.valid?
                expect(job.errors.full_messages_for(:deadline)).to include('Data limite inválida, escolha uma data a partir de hoje.')
            end
        end
    end
end
