# frozen_string_literal: true

module Api
  module V1
    class TransactionsController < ApplicationController
      before_action :set_transaction, only: %w[destroy show update]

      def index
        @transactions = Transaction.all
        json_response(message: 'success', data: @transactions, status: :ok)
      end

      def create
        @transaction = Transaction.create!(transaction_params)
        json_response(message: 'success', data: @transaction, status: :created)
      end

      def show
        json_response(message: 'success', data: @transaction, status: :ok)
      end

      def update
        update_params[:status] = resolve_status(update_params[:status]) if update_params[:status]
        @transaction.update!(update_params)

        json_response(message: 'success', data: @transaction, status: :ok)
      end

      def destroy
        @transaction.destroy
        json_response(message: 'success', status: :no_content)
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
      rescue ActiveRecord::RecordNotFound => e
        record_not_found(e)
      end

      def resolve_status(status_str)
        @statuses = { created: 0, paid: 1, cancelled: 2 }
        @statuses[status_str.to_sym]
      end
    end
  end
end
