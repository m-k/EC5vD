# frozen_string_literal: true

class OrderPriceService
  def initialize(order)
    @order = order
  end

  def call
    basic_order_price
      .then { |basic_price| basic_price - promocodes_deduction }
      .then { |with_applied_promocodes| with_applied_promocodes - discount_code_deduction(with_applied_promocodes) }
      .then { |final_price| final_price.round(2) }
  end

  private

  attr_reader :order

  delegate :items, :promotion_codes, :discount_code, to: :order

  def basic_order_price
    pizzas_price + ingredients_price
  end

  def pizzas_price
    items.sum do |item|
      PizzaPriceService.new(item['name'], item['size']).call
    end
  end

  def ingredients_price
    items.sum do |item|
      ingredients = item['add']
      IngredientsPriceService.new(ingredients, item['size']).call
    end
  end

  def promocodes_deduction
    promotion_codes.sum do |promotion_code|
      PromotionCodeDeductionService.new(promotion_code, order).call
    end
  end

  def discount_code_deduction(price)
    return 0 if discount_code.blank?

    DiscountCodeDeductionService.new(discount_code, price).call
  end
end
