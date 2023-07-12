# frozen_string_literal: true

Rails.application.configure do
  pizza_config_file = Rails.root.join('data/config.yml')
  pizza_config = YAML.load_file(pizza_config_file)

  config.x.pizza_config = OpenStruct.new(pizza_config)
end
