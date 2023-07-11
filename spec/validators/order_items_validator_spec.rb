# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItemsValidator do
  subject(:validator) { described_class.new(attributes: attribute) }

  let(:pizzas) do
    {
      'first_pizza' => 10,
      'second_pizza' => 20
    }
  end
  let(:ingredients) do
    {
      'ingredient_one' => 10,
      'ingredient_two' => 20
    }
  end
  let(:size_multipliers) do
    {
      'one' => 1,
      'two' => 2
    }
  end
  let(:stubbed_config) do
    instance_double(
      'Rails.application.config.x.pizza_config', size_multipliers:, ingredients:, pizzas:
    )
  end
  let(:value) do
    [{
      'name' => name,
      'size' => size,
      'add' => add,
      'remove' => remove
    }]
  end
  let(:remove) { ['ingredient_two'] }
  let(:add) { ['ingredient_one'] }
  let(:size) { 'one' }
  let(:name) { 'first_pizza' }
  let(:attribute) { :order_items }
  let(:errors) { instance_double('errors') }
  let(:record) { instance_double('record', errors:) }

  before do
    allow(Rails.application.config.x).to receive(:pizza_config).and_return(stubbed_config)
  end

  it { is_expected.to delegate_method(:discounts).to(:pizza_config) }
  it { is_expected.to delegate_method(:promotions).to(:pizza_config) }
  it { is_expected.to delegate_method(:size_multipliers).to(:pizza_config) }

  describe '#validate_each' do
    context 'when all items are valid' do
      it 'does not add any errors' do
        expect(record.errors).not_to receive(:add)
        validator.validate_each(record, attribute, value)
      end
    end

    describe 'failure' do
      context 'when name is failure' do
        let(:name) { 'invalid_pizza' }

        it 'adds an error for the attribute' do
          expect(record.errors).to receive(:add).with(attribute, :invalid)
          validator.validate_each(record, attribute, value)
        end
      end

      context 'when size is failure' do
        let(:name) { 'invalid_size' }

        it 'adds an error for the attribute' do
          expect(record.errors).to receive(:add).with(attribute, :invalid)
          validator.validate_each(record, attribute, value)
        end
      end

      context 'when add is failure' do
        context 'when add is invalid' do
          let(:add) { ['invalid_ingredient'] }

          it 'adds an error for the attribute' do
            expect(record.errors).to receive(:add).with(attribute, :invalid)
            validator.validate_each(record, attribute, value)
          end
        end

        context 'when add is not array' do
          let(:add) { 'first_ingredient' }

          it 'adds an error for the attribute' do
            expect(record.errors).to receive(:add).with(attribute, :invalid)
            validator.validate_each(record, attribute, value)
          end
        end
      end

      context 'when remove is failure' do
        context 'when remove is invalid' do
          let(:remove) { ['invalid_ingredient'] }

          it 'adds an error for the attribute' do
            expect(record.errors).to receive(:add).with(attribute, :invalid)
            validator.validate_each(record, attribute, value)
          end
        end

        context 'when remove is not array' do
          let(:remove) { 'second_ingredient' }

          it 'adds an error for the attribute' do
            expect(record.errors).to receive(:add).with(attribute, :invalid)
            validator.validate_each(record, attribute, value)
          end
        end
      end
    end
  end
end
