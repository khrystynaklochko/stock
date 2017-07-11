class StockSerializer < ActiveModel::Serializer
  attributes :id, :name, :deleted

  belongs_to :bearer
  belongs_to :market_price
end
