module Asana
  class Task < Asana::Resource

    def self.all_by_project(*args)
      parent_resources :project
      all(*args)
    end

    def self.all_by_workspace(*args)
      parent_resources :workspace
      all(*args)
    end

    def modify(modified_fields)
      resource = Resource.new(modified_fields)
      response = Task.put(self.id, nil, resource.to_json)
      Task.new(connection.format.decode(response.body))
    end

    def projects
      Project.all_by_task(:params => { :task_id => self.id })
    end

    def add_project(project_id)
      path = "#{self.id}/addProject"
      resource = Resource.new({:project => project_id})
      Task.post(path, nil, resource.to_json)
      self
    end

    def create_story(*args)
      path = "#{self.id}/stories"
      options = { :task => self.id }
      story = Story.new(options.merge(args.first))
      response = Task.post(path, nil, story.to_json)
      Story.new(connection.format.decode(response.body))
    end

    def stories
      Story.all_by_task(:params => { :task_id => self.id })
    end

  end
end
