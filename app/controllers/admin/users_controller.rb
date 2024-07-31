# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    before_action :set_user, only: %i[create update destroy update_admin_status]

    def index
      @users = User.all
    end

    def create
      @user = User.new(user_params)
      unless @user.save
        render json: {}, status: :unprocessable_entity
        return
      end
    end

    def update
      unless @user.update(user_params)
        render json: {}, status: :unprocessable_entity
        return
      end
    end

    def destroy
      if @user&.destroy
        render json: {}, status: :ok
      else
        render json: {}, status: :unprocessable_entity
      end
    end

    def update_admin_status
      unless @user.update(admin: update_admin_params[:admin])
        render json: {}, status: :unprocessable_entity
        return
      end
    end

    private
    
    def set_user
      @user = User.find_by(id: params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def update_admin_params
      params.require(:user).permit(:admin)
    end
  end
end
