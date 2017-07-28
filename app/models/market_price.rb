# frozen_string_literal: true

class MarketPrice < ApplicationRecord
  has_many :stocks

  validates :currency, :value_cents, presence: true
  validates :currency, uniqueness: { scope: :value_cents, message: "Duplicated price" }
  validates :value_cents, numericality: { only_integer: true }
end
