# frozen_string_literal: true

FactoryGirl.define do
  factory :bearer do
    name { Faker::StarWars.character }
  end
end
