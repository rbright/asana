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
  end
end
