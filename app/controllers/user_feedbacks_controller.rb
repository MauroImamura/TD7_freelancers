class UserFeedbacksController < ApplicationController
    before_action :authenticate_worker!, only: [:new, :create]

    def show
        @user_feedback = UserFeedback.find(params[:id])
    end
    
    def new
        @user_feedback = UserFeedback.new
        @job = Job.find(params[:job_id])
    end

    def create
        @user_feedback = UserFeedback.new(params.require(:user_feedback).permit(:rate, :comment, :job_id))
        @user_feedback.job = Job.find(params[:job_id])
        @user_feedback.worker = current_worker
        @user_feedback.user = @user_feedback.job.user
        if @user_feedback.save
            redirect_to @user_feedback , notice: 'Feedback enviado com sucesso!'
        else
            @job = @user_feedback.job
            render :new
        end
    end
end