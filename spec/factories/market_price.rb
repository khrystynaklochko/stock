# frozen_string_literal: true

FactoryGirl.define do
  factory :market_price do
    value_cents { Faker::Number.number(10) }
    currency 'EUR'
  end
end
