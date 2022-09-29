# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
  # Testing the create endpoint
  describe 'POST /api/v1/transactions' do
    let!(:customer) { create(:customer) }
    before do
      post '/api/v1/transactions', params: {
        input_amount: 400.05,
        input_amount_currency: 'USD',
        output_amount: 171_552.56,
        output_amount_currency: 'NGN',
        transaction_date: Date.today,
        customer_id: customer.id
      }
    end

    it 'returns HTTP status 201' do
      expect(response).to have_http_status 201
    end

    it 'returns Correct Data' do
      expect(json_response).to include(
        input_amount: '400.05',
        input_amount_currency: 'USD',
        output_amount: '171552.56',
        output_amount_currency: 'NGN'
      )
    end
  end

  # Testing the update endpoint
  describe 'PUT /api/v1/transactions' do
    let!(:transaction) { create(:transaction) }
    before do
      put "/api/v1/transactions/#{transaction.id}", params: {
        input_amount: 56.05,
        input_amount_currency: 'NGN',
        output_amount: 23_552.56,
        output_amount_currency: 'USD',
        transaction_date: Date.today,
      }
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns Correct Data' do
      expect(json_response).to include(
                                 input_amount: '56.05',
                                 input_amount_currency: 'NGN',
                                 output_amount: '23552.56',
                                 output_amount_currency: 'USD'
                               )
    end
  end

  # Testing the Fetch All endpoint
  describe 'GET /api/v1/transactions' do
    before do
      create_list(:transaction, 10)
      get '/api/v1/transactions', headers: { 'Accept': 'application/json' }
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns all transactions' do
      expect(json_response.size).to eq(10)
    end
  end

  # Testing the Fetch 1 endpoint
  describe 'GET /api/v1/transactions/:id' do
    let!(:transaction) { create(:transaction) }
    before do
      get '/api/v1/transactions', params: { id: transaction.id }
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns Transaction with given ID' do
      expect(json_response[0][:id]).to eq(transaction.id)
    end
  end
end
