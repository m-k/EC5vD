class Order < ApplicationRecord
  enum :state, [:open, :completed]
end
