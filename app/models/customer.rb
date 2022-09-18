# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :transactions

  validates :name, :email, :password, presence: true
  validates :email, uniqueness: true
end
