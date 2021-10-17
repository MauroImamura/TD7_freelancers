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
end