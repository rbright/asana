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

    def stories
      Story.all_by_task(:params => { :task_id => self.id })
    end

    def create_story(*args)
      story = Story.new
      query_options = { :task => self.id }
      Task.post("#{self.id}/stories", query_options.merge(args.first), story.to_json)
    end
  end
end
