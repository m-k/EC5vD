# frozen_string_literal: true

class OrderItemsValidator < ActiveModel::EachValidator
  include PizzaConfig

  ALLOWED_KEYS = %w[name size add remove].freeze

  def validate_each(record, attribute, value)
    record.errors.add attribute, :invalid unless valid?(value)
  end

  private

  def valid?(value)
    value.present? && value.is_a?(Array) && value.all?(&method(:validate_item))
  end

  def validate_item(item)
    valid_item_keys?(item) &&
      valid_item_name?(item['name']) &&
      valid_item_size?(item['size']) &&
      valid_ingredients?(item)
  end

  def valid_item_keys?(item)
    item.keys.sort == ALLOWED_KEYS.sort
  end

  def valid_item_name?(name)
    pizza_names.include? name
  end

  def valid_item_size?(size)
    pizza_sizes.include? size
  end

  def valid_ingredients?(item)
    [item['add'], item['remove']].all? do |ingredients|
      ingredients.blank? ||
        (ingredients.is_a?(Array) && ingredients.all? { |ingredient| pizza_ingredients.include? ingredient })
    end
  end
end
