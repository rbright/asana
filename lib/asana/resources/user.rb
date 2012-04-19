module Asana
  class User < Asana::Resource
    alias :save :method_not_allowed
    alias :destroy :method_not_allowed

    def self.me
      get(:me)
    end
  end
end
