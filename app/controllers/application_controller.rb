class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        if worker_signed_in?
            edit_worker_path(current_worker)
        else
            root_path
        end
    end
end
