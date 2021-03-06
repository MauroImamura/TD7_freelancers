class WorkerFeedbacksController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create]

    def show
        @worker_feedback = WorkerFeedback.find(params[:id])
    end

    def new
        @worker_feedback = WorkerFeedback.new
        @application = Application.find(params[:application_id])
    end

    def create
        @worker_feedback = WorkerFeedback.new(params.require(:worker_feedback).permit(:rate, :comment, :application_id))
        @worker_feedback.application = Application.find(params[:application_id])
        @worker_feedback.user = current_user
        @worker_feedback.worker = @worker_feedback.application.worker
        if @worker_feedback.save
            redirect_to @worker_feedback, notice: 'Feedback enviado com sucesso!'
        else
            @job = @worker_feedback.application.job
            @application = @worker_feedback.application
            render :new
        end
    end
end