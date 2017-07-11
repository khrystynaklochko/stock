# frozen_string_literal: true

class StocksController < ApplicationController
  def index
    json_response(fetch_stocks, ['bearer', 'market_price'])
  end

  def show
    json_response(find_stock)
  end

  private

  def stock_params
    params.require(:stock).permit(:name)
  end

  def fetch_stocks
    Rails.cache.fetch('stocks', expires_in: 5.minutes) { Stock.all }
  end

  def find_stock
    Stock.find(params[:id])
  end
end
