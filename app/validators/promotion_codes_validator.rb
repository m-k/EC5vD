# frozen_string_literal: true

class PromotionCodesValidator < ActiveModel::EachValidator
  include PizzaConfig

  def validate_each(record, attribute, value)
    record.errors.add attribute, :invalid unless valid?(value)
  end

  private

  def valid?(value)
    value.all? do |promotion_code|
      promotions.keys.include? promotion_code
    end
  end
end
