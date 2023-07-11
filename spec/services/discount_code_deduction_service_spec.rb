# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscountCodeDeductionService do
  subject(:result) { described_class.new(code, price).call }

  let(:stubbed_config) { instance_double('Rails.application.config.x.pizza_config', discounts:) }
  let(:discounts) do
    {
      'one' => {
        'deduction_in_percent' => 5
      }
    }
  end

  let(:code) { 'one' }
  let(:price) { 100 }

  before { allow(Rails.application.config.x).to receive(:pizza_config).and_return(stubbed_config) }

  describe '#call' do
    it { is_expected.to eq(5) }
  end
end
