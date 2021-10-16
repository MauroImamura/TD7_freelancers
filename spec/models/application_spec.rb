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
                application = Application.new(expected_deadline: 1.days.ago)
                application.valid?
                expect(application.errors.full_messages_for(:expected_deadline)).to include('Previsão de entrega inválida, escolha uma data a partir de hoje.')
            end
        end
    end
end
