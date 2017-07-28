# frozen_string_literal: true

class Stock < ApplicationRecord

  validates :name, presence: true

  belongs_to :bearer
  belongs_to :market_price

  attr_accessor :bearer_name, :value, :currency

  before_validation :rel_bearer, :rel_market_price

  def soft_delete
    self.bearer.stocks.delete(self)
    self.market_price.stocks.delete(self)
    self.update(deleted: true) 
    true
  end

  private

  def rel_bearer
    self.bearer = Bearer.where(name: bearer_name).first_or_create if bearer_name
  end

  def rel_market_price
    self.market_price = MarketPrice.where(value_cents: value, currency: currency).first_or_create if value && currency
  end

end

