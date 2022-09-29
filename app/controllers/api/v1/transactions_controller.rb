# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :set_transaction, only: %w[destroy show update]

      def index
        @transactions = Transaction.all
        json_response(message: "success", data: @transactions, status: :ok)
      end

      def create
        @transaction = Transaction.create(transaction_params)
        return json_response(message: "error", data: @transaction.errors, status: :unprocessable_entity) unless @transaction.valid?

        json_response(message: "success", data: @transaction, status: :created)
      end

      def show
        return json_response(message: "error", status: :not_found) unless @transaction.present?

        json_response(message: "success", data: @transaction, status: :ok)
      end

      def update
        if update_params[:status]
          update_params[:status] = resolve_status(update_params[:status])
        end
        return json_response(message: "error", status: :not_found) unless @transaction.present?
        @transaction.update!(update_params)

        json_response(message: "success", data: @transaction, status: :ok)
      end

      def destroy
        return json_response(message: "error", status: :not_found) unless @transaction.present?

        @transaction.destroy
        json_response(message: "success", status: :no_content)
      end

      private

      def transaction_params
        params.permit(
          :input_amount_currency, :output_amount_currency,
          :customer_id, :transaction_date, :input_amount, :output_amount
        )
      end

      def update_params
        params.permit(:input_amount_currency, :output_amount_currency,
                      :transaction_date, :input_amount, :output_amount, :status)
      end

      def set_transaction
        @transaction = Transaction.find(params[:id])
      end

      def resolve_status(status_str)
        @statuses = { created: 0, paid: 1, cancelled: 2 }
        @statuses[status_str.to_sym]
      end
    end
  end
end
