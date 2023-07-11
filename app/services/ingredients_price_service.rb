# frozen_string_literal: true

class IngredientsPriceService
  include PizzaConfig

  def initialize(ingredients, size)
    @ingredients = ingredients
    @size = size
  end

  def call
    ingredients_sum * size_multipliers[size]
  end

  private

  attr_reader :ingredients, :size

  def ingredients_sum
    ingredients.sum { |ingredient| ingredients_price[ingredient] }
  end
end
