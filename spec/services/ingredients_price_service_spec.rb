# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IngredientsPriceService do
  subject(:result) { described_class.new(added_ingredients, size).call }

  let(:stubbed_config) do
    instance_double('Rails.application.config.x.pizza_config', size_multipliers:, ingredients:)
  end
  let(:size_multipliers) do
    {
      'one' => 1,
      'two' => 2
    }
  end
  let(:ingredients) do
    {
      'ingredient_one' => 10,
      'ingredient_two' => 20
    }
  end

  let(:added_ingredients) { %w[ingredient_one ingredient_two] }
  let(:size) { 'one' }

  before { allow(Rails.application.config.x).to receive(:pizza_config).and_return(stubbed_config) }

  describe '#call' do
    it { is_expected.to eq((10 + 20) * 1) }

    context 'when size two' do
      let(:size) { 'two' }

      it { is_expected.to eq((10 + 20) * 2) }
    end
  end
end
