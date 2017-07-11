# frozen_string_literal: true

class MarketPrice < ApplicationRecord
  has_many :stocks

  validates :currency, :value_cents, presence: true
end
