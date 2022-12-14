# frozen_string_literal: true

class Transaction < ApplicationRecord
  belongs_to :customer

  enum status: { created: 0, paid: 1, cancelled: 2 }

  validates :input_amount_currency, :output_amount_currency, :customer_id, :transaction_date, presence: true
  validates :input_amount, :output_amount, presence: true, numericality: { greater_than: 0 }
end
