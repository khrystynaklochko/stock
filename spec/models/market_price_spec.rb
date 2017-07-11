# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MarketPrice, type: :model do
  it { should validate_presence_of(:currency) }
  it { should validate_presence_of(:value_cents) }
  it { should have_many(:stocks) }
end
