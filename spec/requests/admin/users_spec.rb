# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Users' do
  let(:admin_user) { create(:user, admin: true) }
  let(:response_hash) { response.parsed_body }

  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(admin_user)
  end

  describe 'GET /users' do
    before do
      get '/admin/users'
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns an array of users' do
      create_list(:user, 3)
      get '/admin/users'
      expect(response_hash['users'].count).to eq 4
    end
  end

  describe 'POST /users' do
    let(:params) do
      {
        user: {
          email: 'random@email.com',
          password: 'password',
          password_confirmation: 'password'
        }
      }
    end

    before do
      post '/admin/users', params:
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the user (id, email)' do
      expect(response_hash.keys).to include('id', 'email')
    end

    context 'when wrong params' do
      let(:params) do
        {
          user: {
            email: 'random@email.com',
            password: 'password',
            password_confirmation: 'wrong_password'
          }
        }
      end

      it 'returns unprocessable entity response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not return the user' do
        expect(response_hash.keys).not_to include('id')
      end
    end
  end

  describe 'PUT /admin/users/:id' do
    let(:user) { create(:user) }
    let(:params) do
      {
        user: {
          email: 'new_email@example.com',
          password: 'newpassword',
          password_confirmation: 'newpassword'
        }
      }
    end

    before do
      put "/admin/users/#{user.id}", params:
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'updates the user email' do
      expect(response_hash['email']).to eq('new_email@example.com')
    end

    context 'when wrong params' do
      let(:params) do
        {
          user: {
            email: 'new_email@example.com',
            password: 'newpassword',
            password_confirmation: 'wrongpassword'
          }
        }
      end

      before do
        put "/admin/users/#{user.id}", params:
      end

      it 'returns unprocessable entity response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not return the user' do
        expect(response_hash.keys).not_to include('id')
      end
    end
  end

  describe 'DELETE /admin/users/:id' do
    let(:user) { create(:user) }

    before do
      delete "/admin/users/#{user.id}"
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'actually deletes the user' do
      expect(User.find_by(id: user.id)).to be_nil
    end

    context 'when user does not exist' do
      before do
        delete "/admin/users/#{user.id + 1}"
      end

      it 'returns unprocessable entity response' do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PUT /admin/users/:id/update_admin_status' do
    let(:user) { create(:user) }
    let(:params) do
      {
        user: {
          admin: true
        }
      }
    end

    before do
      put "/admin/users/#{user.id}/update_admin_status", params:
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'updates the user admin status' do
      expect(response_hash['admin']).to be true
    end
  end
end
