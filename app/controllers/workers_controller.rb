class WorkersController < ApplicationController
    def show
        @worker = Worker.find(params[:id])
    end

    def my_profile
        @worker = current_worker
    end

    def workers_list
        @workers = Worker.all
    end

    def edit
        @worker = current_worker
    end

    def update
        @worker = current_worker
        @worker.update(params.require(:worker).permit(:full_name,:social_name,:description,:birth_date,:education,:experience))
        redirect_to my_profile_path
    end
end