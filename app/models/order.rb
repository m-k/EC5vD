# frozen_string_literal: true

class Order < ApplicationRecord
  enum :state, %i[open completed]

  validates :promotion_codes, promotion_codes: true, allow_nil: true
  validates :discount_code, inclusion: discounts.keys, allow_nil: true
end
