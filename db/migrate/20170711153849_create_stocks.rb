# frozen_string_literal: true

class CreateStocks < ActiveRecord::Migration[5.0]
  def change
    create_table :stocks do |t|
      t.string     :name
      t.belongs_to :bearer, foreign_key: true
      t.belongs_to :market_price, foreign_key: true
      t.boolean    :deleted, default: false

      t.timestamps
    end
  end
end
