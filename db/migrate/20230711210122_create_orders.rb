class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders, id: :uuid do |t|
      t.integer :state, default: 0
      t.jsonb :items
      t.jsonb :promotion_codes
      t.string :discount_code
      t.datetime :created_at, null: false
    end
  end
end
