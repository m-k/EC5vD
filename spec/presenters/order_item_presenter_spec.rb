# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItemPresenter do
  subject(:presenter) { described_class.new(item) }

  let(:item) do
    {
      name:,
      size:,
      add:,
      remove:
    }
  end
  let(:name) { 'Joe' }
  let(:size) { 'small' }
  let(:add) { [] }
  let(:remove) { [] }

  describe '#removed_ingredients' do
    context 'when one ingredient' do
      let(:remove) { ['one'] }

      it { expect(presenter.removed_ingredients).to eq('one') }
    end

    context 'when several ingredients' do
      let(:remove) { %w[one two] }

      it { expect(presenter.removed_ingredients).to eq('one, two') }
    end

    context 'when empty' do
      it { expect(presenter.removed_ingredients).to eq('') }
    end
  end

  describe '#addd_ingredients' do
    context 'when one ingredient' do
      let(:add) { ['one'] }

      it { expect(presenter.added_ingredients).to eq('one') }
    end

    context 'when several ingredients' do
      let(:add) { %w[one two] }

      it { expect(presenter.added_ingredients).to eq('one, two') }
    end

    context 'when empty' do
      it { expect(presenter.added_ingredients).to eq('') }
    end
  end

  describe '#show_remove_section?' do
    context 'when removed ingredients present' do
      let(:remove) { ['one'] }

      it { expect(presenter.show_remove_section?).to be(true) }
    end

    context 'when empty' do
      it { expect(presenter.show_remove_section?).to be(false) }
    end
  end

  describe '#show_add_section?' do
    context 'when added ingredients present' do
      let(:add) { ['one'] }

      it { expect(presenter.show_add_section?).to be(true) }
    end

    context 'when empty' do
      it { expect(presenter.show_add_section?).to be(false) }
    end
  end

  describe '#show_ingredients?' do
    shared_examples 'returns true' do
      it 'returns true' do
        expect(presenter.show_ingredients?).to be(true)
      end
    end

    context 'when added ingredients present' do
      let(:add) { ['one'] }

      include_examples 'returns true'
    end

    context 'when removed ingredients present' do
      let(:remove) { ['one'] }

      include_examples 'returns true'
    end

    context 'when removed and added ingredients present' do
      let(:remove) { ['one'] }
      let(:add) { ['two'] }

      include_examples 'returns true'
    end

    context 'when empty' do
      it { expect(presenter.show_ingredients?).to be(false) }
    end
  end

  describe '#to_partial_path' do
    it { expect(presenter.to_partial_path).to eq('orders/order_item') }
  end
end
