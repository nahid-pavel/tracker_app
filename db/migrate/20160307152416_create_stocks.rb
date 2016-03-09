class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.string :name
      t.string :last_price

      t.timestamps
    end
  end
end
