module Asana
  class Story < Asana::Resource
    alias :update :method_not_allowed

    def self.all_by_task(*args)
      parent_resources :task
      all(*args)
    end
  end
end
