# frozen_string_literal: true

class OrderPresenter < ApplicationPresenter
  include ActionView::Helpers::NumberHelper

  attr_reader :object

  delegate :id, :to_partial_path, to: :object

  EMPTY = '-'
  DELIMITER = ', '

  def initialize(object)
    @object = object
  end

  def created_at
    I18n.l(object.created_at)
  end

  def promotion_codes
    return EMPTY if object.promotion_codes.blank?

    object.promotion_codes.join(DELIMITER)
  end

  def discount_code
    object.discount_code || EMPTY
  end

  def total_price
    price = OrderPriceService.new(object).call
    number_to_currency(price)
  end

  def items
    OrderItemPresenter.wrap(object.items)
  end
end
