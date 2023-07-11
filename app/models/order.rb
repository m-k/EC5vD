# frozen_string_literal: true

class Order < ApplicationRecord
  extend PizzaConfig
  
  enum :state, %i[open completed]

  validates :items, order_items: true
  validates :promotion_codes, promotion_codes: true, allow_nil: true
  validates :discount_code, inclusion: discounts.keys, allow_nil: true
end
