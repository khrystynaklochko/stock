# frozen_string_literal: true

class CreateBearers < ActiveRecord::Migration[5.0]
  def change
    create_table :bearers do |t|
      t.string :name

      t.timestamps
    end
  end
end
