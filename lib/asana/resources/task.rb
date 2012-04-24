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
