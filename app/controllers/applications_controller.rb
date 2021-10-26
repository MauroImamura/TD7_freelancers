class ApplicationsController < ApplicationController
    before_action :authenticate_worker!, only: [:create, :new, :show]
    before_action :authenticate_user!, only: [:accept, :refuse]

    def show
        @application = Application.find(params[:id])
    end

    def new
    end
   
    def create
        @application = Application.new(params.require(:application).permit(:description, :time_per_week, :payment, :expected_deadline, :worker_id))
        @application.worker = current_worker
        @application.job = Job.find(params[:job_id])
        if @application.save
            redirect_to @application, notice: 'Proposta enviada com sucesso!'
        else
            @job = @application.job
            render "jobs/show"
        end
    end

    def accept
        @application = Application.find(params[:id])
        @application.accepted!
        redirect_to @application.job
    end

    def refuse
        @application = Application.find(params[:id])
        @application.refused!
        redirect_to @application.job
    end

    def cancel
        @application = Application.find(params[:id])
        @application.canceled!
        redirect_to job_path(@application.job_id), notice: 'Proposta cancelada com sucesso!'
    end
end