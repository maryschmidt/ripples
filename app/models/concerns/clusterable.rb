module Clusterable
  extend ActiveSupport::Concern

  included do
    # This code will be executed in the context of the class that's including the module
  end

  # Write methods here that you need for clustering

  module ClassMethods
    # These are class methods of the class including the module
    # Pretty cool, huh?!?

    def test_class_count
      return self.count
    end
  end
end
