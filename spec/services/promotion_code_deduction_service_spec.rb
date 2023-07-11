# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromotionCodeDeductionService do
  subject(:result) { described_class.new(promotion_code, order).call }

  let(:stubbed_config) { instance_double('Rails.application.config.x.pizza_config', promotions:) }
  let(:promotions) do
    {
      'code' => {
        'target' => 'first_pizza',
        'target_size' => 'one',
        'from' => from,
        'to' => to
      }
    }
  end
  let(:promotion_code) { 'code' }
  let(:order) { instance_double('Order', items:) }
  let(:items) do
    Array.new(2) do
      {
        'name' => 'first_pizza',
        'size' => 'one'
      }
    end
  end
  let(:pizza_price) { 100 }

  before do
    allow(Rails.application.config.x).to receive(:pizza_config).and_return(stubbed_config)
    allow_any_instance_of(PizzaPriceService).to receive(:call).and_return(pizza_price)
  end

  describe '#call' do
    context 'when from 2 to 1' do
      let(:from) { 2 }
      let(:to) { 1 }

      it { is_expected.to eq(pizza_price) }

      context 'with one pizza in order' do
        let(:items) do
          Array.new(1) do
            {
              'name' => 'first_pizza',
              'size' => 'one'
            }
          end
        end

        it { is_expected.to eq(0) }
      end

      context 'with seven pizza in order' do
        let(:items) do
          Array.new(7) do
            {
              'name' => 'first_pizza',
              'size' => 'one'
            }
          end
        end

        it { is_expected.to eq(pizza_price * 3) }
      end

      context 'with four pizza in order' do
        let(:items) do
          Array.new(4) do
            {
              'name' => 'first_pizza',
              'size' => 'one'
            }
          end
        end

        it { is_expected.to eq(pizza_price * 2) }
      end

      context 'when pizzas another type' do
        context 'when another name' do
          let(:items) do
            Array.new(2) do
              {
                'name' => 'second_pizza',
                'size' => 'one'
              }
            end
          end

          it { is_expected.to eq(0) }
        end

        context 'when another type' do
          let(:items) do
            Array.new(2) do
              {
                'name' => 'first_pizza',
                'size' => 'two'
              }
            end
          end

          it { is_expected.to eq(0) }
        end
      end
    end
  end
end
