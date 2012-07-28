module Asana
  class Project < Asana::Resource

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
      Task.all_by_project(:params => { :project_id => self.id })
    end

    def modify(modified_fields)
      resource = Resource.new(modified_fields)
      response = Project.put(self.id, nil, resource.to_json)
      Project.new(connection.format.decode(response.body))
    end
    
    def create_story(*args)
      path = "#{self.id}/stories"
      story = Story.new(args.first)
      response = Project.post(path, nil, story.to_json)
      Story.new(connection.format.decode(response.body))
    end    

  end
end
