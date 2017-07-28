# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StocksController, type: :controller do

  let(:bearer) { FactoryGirl.create(:bearer, name: 'New') }
  let(:market_price) { FactoryGirl.create(:market_price, currency: 'EUR', value_cents: 150) }
  let(:stock) { FactoryGirl.create(:stock, name:'New', bearer: bearer, market_price: market_price) }
  let(:stocks) { (1..10).each { |n| FactoryGirl.create(:stock, name:"New #{n}", bearer: bearer, market_price: market_price) }}

  describe 'GET /stocks/' do
    it 'should return list with stocks' do
      stocks
      get :index, as: :json

      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['data'].first['attributes']['name']).to eq('New 1')
      expect(json['data'].count).to eq(10)
    end
  end

  describe 'GET /stocks/:id' do
    it 'should return one stock by id' do
      get :show, as: :json, params: { id: stock.id }

      expect(response).to have_http_status(200)
      json = JSON.parse(response.body)
      expect(json['data']['attributes']['name']).to eq('New')
    end
  end

  describe 'POST /stocks/' do

    let(:valid_params) {{ stock: { name: 'valid',
                                   bearer: 'valid',
                                   value: 19,
                                   currency: 'EUR' }}}

    let(:invalid_params) {{  stock: { name: 'invalid',
                                      bearer: 'invalid',
                                      value: 19.39,
                                      currency: 'EUR' }}}

    context 'with valid data' do
      it 'should return stock and 200 OK' do
        post :create, as: :json, params: valid_params

        expect(response).to have_http_status(201)
        json = JSON.parse(response.body)
        expect(json['data']['attributes']['name']).to eq('valid')
        expect(Stock.count).to eq(1)
        expect(Bearer.count).to eq(1)
        expect(MarketPrice.count).to eq(1)
      end
    end

    context 'with invalid data' do
      it 'should return 422 and fail to save' do
        post :create, as: :json, params: invalid_params

        expect(response).to have_http_status(422)
        expect(JSON.parse(response.body)).to eq({ 'error' => { 'name' => ['is invalid'],
                                                               'bearer' => ['is invalid'] } })
        expect(Stock.count).to eq(0)
        expect(Bearer.count).to eq(0)
        expect(MarketPrice.count).to eq(0)
      end
    end
  end

  describe 'PATCH /stocks/:id' do
    context 'with different bearer' do
      it 'should create new bearer but keep market price' do
        stock
        put :update, as: :json, params: { id: stock.id,
                                          stock: { bearer: 'New 2', 
                                                   currency: market_price.currency, 
                                                   value: 150
                                                 }}

        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json['data']['attributes']['name']).to eq(stock.name)
        expect(json['data']['attributes']['bearer']['name']).to eq('New 2')
        expect(Bearer.count).to eq(2)
        expect(MarketPrice.count).to eq(1)
      end
    end

    context 'with different market price' do
      it 'should create new market price but keep bearer' do
        stock
        put :update, as: :json, params: { id: stock.id,
                                          stock: { bearer: 'New', 
                                                   currency: market_price.currency, 
                                                   value: 82 }}

        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json['data']['attributes']['name']).to eq('New')
         expect(json['data']['attributes']['market-price']['value_cents']).to eq(82)
        expect(MarketPrice.last.value_cents).to eq(82)
        expect(Bearer.count).to eq(1)
        expect(MarketPrice.count).to eq(2)
        expect(Stock.count).to eq(1)
      end
    end

    context 'with existing bearer' do
      it 'should reference existing bearer to stock' do
        bearer
        stock
        put :update, as: :json, params: { id: stock.id,
                                           stock: { bearer: bearer.name,
                                                    currency: market_price.currency, 
                                                    value: 82 }}

        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json['data']['attributes']['name']).to eq('New')
        expect(json['data']['attributes']['bearer']['name']).to eq('New')
        expect(Stock.first.name).to eq('New')
        expect(MarketPrice.last.value_cents).to eq(82)
        expect(Bearer.count).to eq(1)
        expect(MarketPrice.count).to eq(2)
      end
    end
  end

  describe 'DELETE /stocks/:id' do
    context 'dependent destroy' do
      it 'should soft delete stock from related objects' do
        bearer
        market_price
        stock
        expect(Stock.count).to eq(1)
        expect(Stock.first.deleted).to eq(false)
        expect(MarketPrice.first.stocks.count).to eq(1)
        expect(Bearer.first.stocks.count).to eq(1)

        delete :destroy, as: :json, params: { id: stock.id }

        expect(response).to have_http_status(200)
        json = JSON.parse(response.body)
        expect(json['message']).to eq('Stock was deleted.')
        expect(MarketPrice.first.stocks.count).to eq(0)
        expect(Bearer.first.stocks.count).to eq(0)
        expect(Stock.count).to eq(1)
        expect(Stock.first.deleted).to eq(true)
        expect(Stock.first.bearer_id).to eq(nil)
        expect(Stock.first.market_price_id).to eq(nil)
      end
    end
  end
end
