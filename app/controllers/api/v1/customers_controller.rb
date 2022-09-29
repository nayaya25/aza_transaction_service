# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      before_action :set_customer, only: %w[destroy show]

      def index
        @customers = Customer.all
        json_response(message: "success", data: @customers, status: :ok)
      end

      def create
        @customer = Customer.create(customer_params)
        return json_response(message: "error", data: @customer.errors, status: :unprocessable_entity) unless @customer.valid?

        json_response(message: "success", data: @customer, status: :created)
      end

      def show
        return json_response(message: "error", status: :not_found) unless @customer.present?

        json_response(message: "success", data: @customer, status: :ok)
      end

      def destroy
        return json_response(message: "error", status: :not_found) unless @customer.present?

        @customer.destroy
        json_response(message: "success", status: :no_content)
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
