# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Customers', type: :request do
  describe 'GET /api/v1/customers' do
    before do
      create_list(:customer, 10)
      get '/api/v1/customers', headers: { 'Accept': 'application/json' }
    end

    it 'returns HTTP status 200' do
      expect(response).to have_http_status 200
    end

    it 'returns all users' do
      expect(json_response.size).to eq(10)
    end
  end
end
