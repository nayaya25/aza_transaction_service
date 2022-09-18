
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Transactions', type: :request do
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
