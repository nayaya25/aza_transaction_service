# frozen_string_literal: true

class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.decimal :input_amount, precision: 15, scale: 2
      t.string :input_amount_currency
      t.decimal :output_amount, precision: 15, scale: 2
      t.string :output_amount_currency
      t.datetime :transaction_date
      t.belongs_to :customer

      t.timestamps
    end
  end
end
