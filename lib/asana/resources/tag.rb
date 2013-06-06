module Asana
  class Tag < Asana::Resource

    alias :create :method_not_allowed
    alias :destroy :method_not_allowed

    def self.all_by_task(*args)
      parent_resources :task
      all(*args)
    end

    def self.all_by_workspace(*args)
      parent_resources :workspace
      all(*args)
    end

    def tasks
      Task.all_by_tag(:params => { :tag_id => self.id })
    end

    def modify(modified_fields)
      resource = Resource.new(modified_fields)
      response = Tag.put(self.id, nil, resource.to_json)
      Tag.new(connection.format.decode(response.body))
    end

  end
end
