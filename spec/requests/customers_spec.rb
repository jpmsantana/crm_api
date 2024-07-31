# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers' do
  let(:user) { create(:user) }
  let(:response_hash) { response.parsed_body }

  before do
    allow_any_instance_of(ApplicationController)
      .to receive(:current_user).and_return(user)
  end

  describe 'GET /customers' do
    before do
      create_list(:customer, 5)
      get '/customers'
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns a list of customers' do
      expect(response_hash.count).to eq 5
    end
  end

  describe 'GET /customers/:id' do
    let(:customer) { create(:customer) }

    before do
      get "/customers/#{customer.id}"
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns the customer' do
      expect(response_hash).to include(
        'id' => customer.id,
        'name' => customer.name,
        'surname' => customer.surname
      )
    end
  end

  describe 'POST /customers' do
    let(:customer_params) { attributes_for(:customer) }

    before do
      post '/customers', params: { customer: customer_params }
    end

    it 'returns created response' do
      expect(response).to have_http_status(:created)
    end

    it 'returns the created customer' do
      expect(response_hash).to include(
        'name' => customer_params[:name],
        'surname' => customer_params[:surname]
      )
    end

    it 'saves the user_id of the creator' do
      expect(response_hash['user_id']).to eq(user.id)
    end
  end

  describe 'PUT /customers/:id' do
    let(:customer) { create(:customer) }
    let(:updated_name) { 'updated name' }
    let(:updated_surname) { 'updated surname' }
    let(:params) do
      {
        customer: {
          name: updated_name,
          surname: updated_surname
        }
      }
    end

    before do
      put "/customers/#{customer.id}", params:
    end

    it 'returns ok response' do
      expect(response).to have_http_status(:ok)
    end

    it 'updates the customer' do
      expect(response_hash).to include(
        'name' => updated_name,
        'surname' => updated_surname
      )
    end
  end

  describe 'DELETE /customers/:id' do
    let(:customer) { create(:customer) }

    before do
      delete "/customers/#{customer.id}"
    end

    it 'returns no content response' do
      expect(response).to have_http_status(:ok)
    end

    it 'deletes the customer' do
      expect(Customer.find_by(id: customer.id)).to be_nil
    end
  end
end
