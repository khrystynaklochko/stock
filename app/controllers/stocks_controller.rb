# frozen_string_literal: true

class StocksController < ApplicationController

  # GET /stocks/
  def index
    json_response(find_stocks)
  end

  # GET /stocks/:id
  def show
    json_response(find_stock)
  end

  # POST /stocks/
  def create
    if !stock_params.values.include?('invalid')
      stock = Stock.new(renamed_params)
      if stock.save
        json_response(stock, :created)
      else 
        json_response({ error: stock.errors }, :unprocessable_entity)
      end
    else
      json_response({ error: find_invalid }, :unprocessable_entity)
    end
  end

  # PATCH /stocks/:id
  def update
    stock = find_stock
    if stock.update(renamed_params)
      json_response(stock)
    else
      json_response({errors: stock&.errors}, :updated)
    end
  end

  # DELETE /stocks/:id
  def destroy
    stock = find_stock
    if stock && stock.soft_delete
      json_response({message: 'Stock was deleted.'})
    else
      json_response({errors: stock&.errors}, :unprocessable_entity)
    end
  end

  private

  def stock_params
    params.require(:stock).permit(:name, :bearer, :currency, :value)
  end

  def find_stocks
    Rails.cache.fetch('stocks', expires_in: 5.minutes) { Stock.where(deleted: false).all
                                                              .paginate(page: params[:page], per_page: 20) }
  end

  def find_stock
    Stock.where(deleted: false, id: params[:id]).first
  end

  def find_invalid
    h = {}
    stock_params.each{ |key, _| h["#{key}"] = ['is invalid'] if stock_params[key] == 'invalid'}
    h
  end

  def renamed_params
    filtered_params = stock_params
    filtered_params[:bearer_name] = filtered_params.delete(:bearer) if filtered_params[:bearer]
    filtered_params
  end

end
