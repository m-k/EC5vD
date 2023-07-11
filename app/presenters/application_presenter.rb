# frozen_string_literal: true

class ApplicationPresenter
  def self.wrap(collection)
    collection.map(&method(:new))
  end
end
