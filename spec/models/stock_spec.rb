# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Stock, type: :model do
  it { should validate_presence_of(:name) }
  it { should belong_to(:bearer) }
  it { should belong_to(:market_price) }
end
