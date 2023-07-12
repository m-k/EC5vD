# frozen_string_literal: true

class DiscountCodeDeductionService
  include PizzaConfig

  def initialize(code, price)
    @code = code
    @price = price
  end

  def call
    price * discount_percentage / 100
  end

  private

  attr_reader :code, :price

  def discount_percentage
    discount['deduction_in_percent']
  end

  def discount
    discounts[code]
  end
end
