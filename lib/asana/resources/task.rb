module Asana
  class Task < Asana::Resource

    def self.all_by_project(*args)
      parent_resources :project
      all(*args)
    end

    def self.all_by_tag(*args)
      parent_resources :tag
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

    def tags
      Tag.all_by_task(:params => { :task_id => self.id })
    end

    def add_project(project_id)
      path = "#{self.id}/addProject"
      resource = Resource.new({:project => project_id})
      Task.post(path, nil, resource.to_json)
      self
    end

    def remove_project(project_id)
      path = "#{self.id}/removeProject"
      resource = Resource.new({:project => project_id})
      Task.post(path, nil, resource.to_json)
      self
    end

    def add_tag(tag_id)
      path = "#{self.id}/addTag"
      resource = Resource.new({:tag => tag_id})
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

    def create_subtask(*args)
      path = "#{self.id}/subtasks"
      options = { :task => self.id }
      task = Task.new(options.merge(args.first))
      response = Task.post(path, nil, task.to_json)
      Task.new(connection.format.decode(response.body).merge parent: self)
    end

    def subtasks
      path = "#{self.id}/subtasks"
      Task.get(path, nil).map { |subtask| Task.new(subtask.merge(parent: self)) }
    end

  end
end
