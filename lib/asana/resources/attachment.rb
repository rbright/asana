module Asana
  class Attachment < Asana::Resource

    alias :destroy :method_not_allowed
    alias :update :method_not_allowed

    def self.all_by_task(*args)
      parent_resources :task
      all(*args)
    end

  end
end
