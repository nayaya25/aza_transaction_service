# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :set_transaction, only: %w[destroy show]

      def index
        @transactions = Transaction.all
        json_response(data: @transactions, status: :ok)
      end

      def create
        @transaction = Transaction.create(customer_params)
        return json_response(data: @transaction.errors, status: :unprocessable_entity) unless @transaction.valid?

        json_response(data: @transaction, status: :created)
      end

      def show
        return json_response(status: :not_found) unless @transaction.present?

        json_response(data: @transaction, status: :ok)
      end

      def destroy
        return json_response(status: :not_found) unless @transaction.present?

        @transaction.destroy
        json_response(status: :no_content)
      end

      private

      def transaction_params
        params.permit(
          :input_amount_currency, :output_amount_currency,
          :customer_id, :transaction_date, :input_amount, :output_amount
        )
      end

      def set_transaction
        @transaction = Transaction.find(params[:id])
      end
    end
  end
end
