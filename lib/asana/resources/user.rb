module Asana
  class User < Asana::Resource
    alias :save :method_not_allowed
    alias :destroy :method_not_allowed

    def self.all_by_workspace(*args)
      parent_resources :workspace
      all(*args)
    end

    def self.me
      User.new(get(:me))
    end
  end
end
