class JobsController < ApplicationController
    before_action :authenticate_user!, only: [:create]

    def show
        @job = Job.find(params[:id])
        @application = Application.new
        flash[:notice] = 'Projeto cadastrado com sucesso!'
    end

    def new
        @job = Job.new
    end

    def create
        @job = Job.new(params.require(:job).permit(:title, :description, :skills, :payment, :in_person, :deadline, :user_id))
        @job.user = current_user
        if @job.save
            redirect_to @job
        else
            render :new
        end
    end

    def my_jobs
        @jobs = current_user.jobs
    end

    def accepted_jobs
        @applications = current_worker.applications
    end

    def jobs_list
        @jobs = Job.all
    end

    def finish_hiring
        @job = Job.find(params[:id])
        @job.Executando!
        redirect_to @job
    end

    def finish_project
        @job = Job.find(params[:id])
        @job.Finalizado!
        redirect_to @job
    end
end