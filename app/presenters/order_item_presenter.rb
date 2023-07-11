# frozen_string_literal: true

class OrderItemPresenter < ApplicationPresenter
  attr_reader :object

  delegate :name, :size, to: :object

  DELIMITER = ', '

  def initialize(object)
    @object = OpenStruct.new(object)
  end

  def show_ingredients?
    added_ingredients.present? || removed_ingredients.present?
  end

  def show_add_section?
    added_ingredients.present?
  end

  def show_remove_section?
    removed_ingredients.present?
  end

  def added_ingredients
    object.add.join(DELIMITER)
  end

  def removed_ingredients
    object.remove.join(DELIMITER)
  end
end
