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
    end
end
