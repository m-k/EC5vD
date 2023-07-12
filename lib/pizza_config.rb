# frozen_string_literal: true

module PizzaConfig
  private

  delegate :pizza_config, to: :'Rails.application.config.x'
  delegate :discounts, :promotions, :size_multipliers, to: :pizza_config

  def base_pizza_price
    pizza_config.pizzas
  end

  def ingredients_price
    pizza_config.ingredients
  end

  def pizza_names
    base_pizza_price.keys
  end

  def pizza_sizes
    size_multipliers.keys
  end

  def pizza_ingredients
    ingredients_price.keys
  end
end
