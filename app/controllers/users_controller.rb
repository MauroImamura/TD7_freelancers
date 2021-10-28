class UsersController < ApplicationController
    def user_feedback_list
        @user = User.find(params[:id])
    end
end