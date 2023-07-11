# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderPresenter do
  subject(:presenter) { described_class.new(order) }

  let(:order) { Order.new(**order_attributes) }
  let(:order_attributes) do
    {
      state:,
      items:,
      promotion_codes:,
      discount_code:,
      created_at:
    }
  end
  let(:state) { :open }
  let(:items) { {} }
  let(:promotion_codes) { [] }
  let(:discount_code) { nil }
  let(:created_at) { DateTime.new(2022, 2, 24, 4, 15) }

  describe '#created_at' do
    it { expect(presenter.created_at).to eq('February 24, 2022 04:15') }
  end

  describe '#promotion_codes' do
    context 'when one promocode' do
      let(:promotion_codes) { ['one'] }

      it { expect(presenter.promotion_codes).to eq('one') }
    end

    context 'when several promocodes' do
      let(:promotion_codes) { %w[one two] }

      it { expect(presenter.promotion_codes).to eq('one, two') }
    end

    context 'when empty' do
      it { expect(presenter.promotion_codes).to eq('-') }
    end
  end

  describe '#discount_code' do
    context 'when present' do
      let(:discount_code) { 'one' }

      it { expect(presenter.discount_code).to eq('one') }
    end

    context 'when empty' do
      it { expect(presenter.discount_code).to eq('-') }
    end
  end

  describe '#total_price' do
    it 'returns formatted total price' do
      allow_any_instance_of(OrderPriceService).to receive(:call).and_return('11.22')

      expect(presenter.total_price).to eq('11.22€')
    end
  end

  describe '#items' do
    let(:item) { instance_double('OrderItemPresenter') }

    it 'returns items' do
      expect(OrderItemPresenter).to receive(:wrap).and_return(item)

      expect(presenter.items).to eq(item)
    end
  end
end
