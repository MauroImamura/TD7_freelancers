class FavoritedWorkersController < ApplicationController
    before_action :authenticate_user!, only: [:add]

    def add
        @favorited_worker = FavoritedWorker.new
        @favorited_worker.checked = true
        @favorited_worker.user = current_user
        @favorited_worker.worker = Worker.find(params[:id])
        if @favorited_worker.save
            redirect_to @favorited_worker.worker, notice: 'Profissional adicionado aos favoritos'
        else
            redirect_to @favorited_worker.worker, notice: 'Não foi possível adicionar aos favoritos'
        end
    end
end