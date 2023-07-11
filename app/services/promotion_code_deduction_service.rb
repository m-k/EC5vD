# frozen_string_literal: true

class PromotionCodeDeductionService
  include PizzaConfig

  def initialize(promotion_code, order)
    @promotion_code = promotion_code
    @order = order
  end

  def call
    pizza_price * deduction_multiplier
  end

  private

  attr_reader :promotion_code, :order

  def promotion
    promotions[promotion_code]
  end

  def required_quantity
    promotion['from']
  end

  def paid_quantity
    promotion['to']
  end

  def applicable_pizza
    promotion['target']
  end

  def applicable_size
    promotion['target_size']
  end

  def pizza_price
    PizzaPriceService.new(applicable_pizza, applicable_size).call
  end

  def times_applied
    targets_count / required_quantity
  end

  def targets_count
    order.items.count do |item|
      item['name'] == applicable_pizza && item['size'] == applicable_size
    end
  end

  def deduction_multiplier
    (required_quantity - paid_quantity) * times_applied
  end
end
