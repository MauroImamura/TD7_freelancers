class ApplicationsController < ApplicationController
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
end