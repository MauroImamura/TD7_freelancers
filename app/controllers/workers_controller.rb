class WorkersController < ApplicationController
    def my_profile
        @worker = current_worker
    end
end