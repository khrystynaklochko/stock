# frozen_string_literal: true

FactoryGirl.define do
  factory :stock do
    name  { Faker::StarWars.character }
    bearer { build(:bearer) }
    market_price { build(:market_price) }
    deleted false
  end
  factory :stock_2, class: Stock do
    name  { Faker::StarWars.character }
    bearer { build(:bearer) }
    market_price { build(:market_price) }
    deleted false
  end
end
