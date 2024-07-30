class SessionsController < ApplicationController
  skip_before_action :authorized, only: :create

  def create
    user = User.find_by(email: session_params[:email])

    if user.nil? || !user.authenticate(session_params[:password])
      render json: {}, status: :unauthorized
      return
    end

    token = encode_token(id: user.id)
    render json: { user: { email: user.email }, jwt: token }
  end

  def show
    render json: { user: { email: current_user.email } }
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
