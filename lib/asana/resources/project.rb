module Asana
  class Project < Asana::Resource
    alias :create :method_not_allowed

    def self.all_by_workspace(*args)
      parent_resources :workspace
      all(*args)
    end
  end
end
