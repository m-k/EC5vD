# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order do
  it { is_expected.to have_db_column(:state).of_type(:integer).with_options(default: 'open') }
  it { is_expected.to have_db_column(:items).of_type(:jsonb) }
  it { is_expected.to have_db_column(:promotion_codes).of_type(:jsonb) }
  it { is_expected.to have_db_column(:discount_code).of_type(:string) }
  it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }

  it { is_expected.to define_enum_for(:state).with_values(open: 0, completed: 1) }
end
