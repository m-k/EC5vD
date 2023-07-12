# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderPriceService do
  subject(:result) { described_class.new(order).call }

  let(:order) { instance_double('Order', items:, promotion_codes:, discount_code:) }
  let(:pizza_price) { 100 }
  let(:ingredients_price) { 20 }
  let(:promotion_deduction) { 10 }
  let(:discount_deduction) { 5 }

  let(:items) do
    [{
      'name' => 'first_pizza',
      'size' => 'one'
    }]
  end
  let(:promotion_codes) { ['promotion_code'] }
  let(:discount_code) { 'discount_code' }

  before do
    allow_any_instance_of(PizzaPriceService).to receive(:call).and_return(pizza_price)
    allow_any_instance_of(IngredientsPriceService).to receive(:call).and_return(ingredients_price)
    allow_any_instance_of(PromotionCodeDeductionService).to receive(:call).and_return(promotion_deduction)
    allow_any_instance_of(DiscountCodeDeductionService).to receive(:call).and_return(discount_deduction)
  end

  describe '#call' do
    it { is_expected.to eq(pizza_price + ingredients_price - promotion_deduction - discount_deduction) }
  end
end
