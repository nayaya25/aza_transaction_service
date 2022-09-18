# frozen_string_literal: true

FactoryBot.define do
  factory :transaction do
    input_amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    input_amount_currency { Faker::Currency.code }
    output_amount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    output_amount_currency { Faker::Currency.code }
    transaction_date { Faker::Date.between(from: 5.days.ago, to: Date.today) }
    customer
  end
end
