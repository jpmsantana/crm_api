# frozen_string_literal: true

module Admin
  class UsersController < ApplicationController
    def index
      users = User.all
      render json: users
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: { id: user.id, email: user.email, admin: user.admin }
      else
        render json: {}, status: :unprocessable_entity
      end
    end

    def update
      user = User.find_by(id: params[:id])
      if user.update(user_params)
        render json: { id: user.id, email: user.email, admin: user.admin }
      else
        render json: {}, status: :unprocessable_entity
      end
    end

    def destroy
      user = User.find_by(id: params[:id])
      if user&.destroy
        render json: {}, status: :ok
      else
        render json: {}, status: :unprocessable_entity
      end
    end

    def update_admin_status
      user = User.find_by(id: params[:id])
      if user.update(admin: update_admin_params[:admin])
        render json: { id: user.id, email: user.email, admin: user.admin }
      else
        render json: {}, status: :unprocessable_entity
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def update_admin_params
      params.require(:user).permit(:admin)
    end
  end
end
