# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PromotionCodesValidator do
  let(:record) { instance_double('record', errors:) }
  let(:errors) { instance_double('errors') }
  let(:attribute) { :promotion_codes }
  let(:validator) { described_class.new(attributes: attribute) }

  before do
    allow(validator).to receive(:promotions).and_return({
                                                          '3FOR2' => '3FOR2_promotion_settings',
                                                          'SAVE_SALAMI' => 'SAVE_SALAMI_promotion_settings'
                                                        })
  end

  describe '#validate_each' do
    context 'when all promotion codes are valid' do
      let(:value) { %w[3FOR2 SAVE_SALAMI] }

      it 'does not add any errors' do
        expect(record.errors).not_to receive(:add)
        validator.validate_each(record, attribute, value)
      end
    end

    context 'when at least one promotion code is invalid' do
      let(:value) { %w[3FOR2 invalid_code] }

      it 'adds an error for the attribute' do
        expect(record.errors).to receive(:add).with(attribute, :invalid)
        validator.validate_each(record, attribute, value)
      end
    end

    context 'when promotion codes empty' do
      let(:value) { [] }

      it 'adds an error for the attribute' do
        expect(record.errors).not_to receive(:add)
        validator.validate_each(record, attribute, value)
      end
    end
  end
end
