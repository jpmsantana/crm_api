# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized
  before_action :ensure_json_request
  helper_method :current_user

  def ensure_json_request
    request.format = :json
  end

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.secret_key_base)
  end

  def decoded_token
    header = request.headers['Authorization']
    return unless header

    token = header.split[1]
    begin
      JWT.decode(token, Rails.application.credentials.secret_key_base)
    rescue JWT::DecodeError
      nil
    end
  end

  def current_user
    return unless decoded_token

    user_id = decoded_token[0]['id']
    @user = User.find_by(id: user_id)
  end

  def authorized
    return if current_user

    render json: { message: 'Please log in' }, status: :unauthorized
  end

  def admin_authorized
    return if current_user&.admin?

    render json: { message: 'Please log in as an admin' }, status: :unauthorized
  end
end
