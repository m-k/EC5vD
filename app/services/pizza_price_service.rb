# frozen_string_literal: true

class PizzaPriceService
  include PizzaConfig

  def initialize(name, size)
    @name = name
    @size = size
  end

  def call
    base_pizza_price[name] * size_multipliers[size]
  end

  private

  attr_reader :name, :size
end
