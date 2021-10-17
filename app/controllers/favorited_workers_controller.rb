class FavoritedWorkersController < ApplicationController
    def add
        @favorited_worker = FavoritedWorker.new
        @favorited_worker.checked = true
        @favorited_worker.user = current_user
        @favorited_worker.worker = Worker.find(params[:id])
        redirect_to @favorited_worker.worker, notice: 'Profissional adicionado aos favoritos'
    end
end