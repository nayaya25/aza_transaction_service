# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      before_action :set_customer, only: %w[destroy show]

      def index
        @customers = Customer.all
        json_response(data: @customers, status: :ok)
      end

      def create
        @customer = Customer.create(customer_params)
        return json_response(data: @customer.errors, status: :unprocessable_entity) unless @customer.valid?

        json_response(data: @customer, status: :created)
      end

      def show
        return json_response(status: :not_found) unless @customer.present?

        json_response(data: @customer, status: :ok)
      end

      def destroy
        return json_response(status: :not_found) unless @customer.present?

        @customer.destroy
        json_response(status: :no_content)
      end

      private

      def customer_params
        params.permit(:name, :email, :password)
      end

      def set_customer
        @customer = Customer.find(params[:id])
      end
    end
  end
end
