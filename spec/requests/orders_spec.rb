# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Orders' do
  let(:stubbed_config) do
    instance_double('Rails.application.config.x.pizza_config', size_multipliers:, ingredients:, pizzas:)
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
  let(:pizzas) do
    {
      'first_pizza' => 10,
      'second_pizza' => 20
    }
  end

  let(:order) { Order.create(**order_attributes) }
  let(:order_attributes) do
    {
      state:,
      items:,
      promotion_codes:,
      discount_code:
    }
  end
  let(:state) { :open }
  let(:items) do
    [{
      'name' => 'first_pizza',
      'size' => 'one',
      'add' => [],
      'remove' => []
    }]
  end
  let(:promotion_codes) { [] }
  let(:discount_code) { nil }

  before do
    allow(Rails.application.config.x).to receive(:pizza_config).and_return(stubbed_config)
  end

  describe 'GET /index' do
    context 'with orders' do
      before { order }

      it 'returns http success' do
        get '/'
        expect(response).to have_http_status(:success)
        expect(response.body).to include('Orders')
        expect(response.body).to include('first_pizza')
        expect(response.body).to include('one')
        expect(response.body).to include('Total Price')
      end
    end

    context 'without orders' do
      it 'returns http success' do
        get '/'
        expect(response).to have_http_status(:success)
        expect(response.body).to include('Orders')
        expect(response.body).not_to include('Total Price')
      end
    end
  end

  describe 'PATCH /update' do
    let(:params) { { order: { state: :completed } } }

    before { order }

    it 'returns http success' do
      patch("/orders/#{order.id}", params:)
      expect(response).to redirect_to(root_path)
      expect(order.reload).to be_completed
    end

    it 'returns not found' do
      expect do
        patch '/orders/9999', params:
      end.to raise_exception ActiveRecord::RecordNotFound
    end
  end
end
