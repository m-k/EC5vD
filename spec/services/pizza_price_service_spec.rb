# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PizzaPriceService do
  subject(:result) { described_class.new(name, size).call }

  let(:stubbed_config) do
    instance_double('Rails.application.config.x.pizza_config', size_multipliers:, pizzas:)
  end
  let(:size_multipliers) do
    {
      'one' => 1,
      'two' => 2
    }
  end
  let(:pizzas) do
    {
      'first_pizza' => 10,
      'second_pizza' => 20
    }
  end
  let(:name) { 'first_pizza' }
  let(:size) { 'one' }

  before { allow(Rails.application.config.x).to receive(:pizza_config).and_return(stubbed_config) }

  describe '#call' do
    it { is_expected.to eq(10 * 1) }

    context 'when size two' do
      let(:name) { 'second_pizza' }
      let(:size) { 'two' }

      it { is_expected.to eq(20 * 2) }
    end
  end
end
