require 'rails_helper'

describe UserFeedback do
    context 'validation' do
        context 'presence' do
            it 'rate must be present' do              
                user_feedback = UserFeedback.new
                user_feedback.valid?
                expect(user_feedback.errors.full_messages_for(:rate)).to include('Nota não pode ficar em branco')
            end
            it 'comment must be present' do
                user_feedback = UserFeedback.new
                user_feedback.valid?
                expect(user_feedback.errors.full_messages_for(:comment)).to include('Comentários não pode ficar em branco')
            end
        end

        context 'numericality' do
            it 'rate must be greater than or equals to zero' do
                user_feedback = UserFeedback.new(rate: -1)
                user_feedback.valid?
                expect(user_feedback.errors.full_messages_for(:rate)).to include('Nota deve ser maior ou igual a 0')
            end
            it 'rate must be greater than or equals to zero' do
                user_feedback = UserFeedback.new(rate: 0)
                user_feedback.valid?
                expect(user_feedback.errors.full_messages_for(:rate)).to eq []
            end
            it 'rate must be less than or equals to five' do
                user_feedback = UserFeedback.new(rate: 6)
                user_feedback.valid?
                expect(user_feedback.errors.full_messages_for(:rate)).to include('Nota deve ser menor ou igual a 5')
            end
            it 'rate must be less than or equals to five' do
                user_feedback = UserFeedback.new(rate: 5)
                user_feedback.valid?
                expect(user_feedback.errors.full_messages_for(:rate)).to eq []
            end
        end

        context 'text length' do
            it 'comment has more than 100 characters' do
                user_feedback = UserFeedback.new(comment: 'Bommmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm')
                user_feedback.valid?
                expect(user_feedback.errors.full_messages_for(:comment)).to include('Comentários é muito longo (máximo: 100 caracteres)')
            end
            it 'comment has up to 100 characters' do
                user_feedback = UserFeedback.new(comment: 'Bommmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmmm')
                user_feedback.valid?
                expect(user_feedback.errors.full_messages_for(:comment)).to eq []
            end
        end
    end
end
