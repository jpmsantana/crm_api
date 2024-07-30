require 'rails_helper'

RSpec.describe 'Sessions' do
  let(:user) { create(:user) }
  let(:response_hash) { JSON.parse(response.body) }

  describe 'POST /session' do
    before do
      post '/session', params: { email: user.email, password: 'password' }
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the authenticated user' do
      expect(response_hash['user'].keys).to include('email')
    end

    it 'returns the token' do
      expect(response_hash.keys).to include('jwt')
    end

    context 'when password is wrong' do
      before do
        post '/session', params: { email: user.email, password: 'wrong_password' }
      end

      it 'returns no user' do
        expect(response_hash.keys).not_to include('user')
      end

      it 'returns no token' do
        expect(response_hash.keys).not_to include('jwt')
      end
    end
  end

  describe 'GET /session' do
    before do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      get '/session'
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the authenticated user' do
      expect(response_hash['user'].keys).to include('email')
    end
  end
end
