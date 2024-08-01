# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authorized, only: :create

  def show; end

  def create
    @user = User.find_by(email: session_params[:email])

    if @user.nil? || !@user.authenticate(session_params[:password])
      render json: {}, status: :unauthorized
      return
    end

    @token = encode_token(id: @user.id)
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
