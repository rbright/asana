module Asana
  class Workspace < Asana::Resource

    alias :create :method_not_allowed
    alias :destroy :method_not_allowed

    def projects
      Project.all_by_workspace(:params => { :workspace_id => self.id })
    end

    def create_project(*args)
      options = { :workspace => self.id }
      project = Project.new(options.merge(args.first))
      response = Project.post(nil, nil, project.to_json)
      Project.new(connection.format.decode(response.body))
    end

    def tasks(assignee)
      query_options = { :workspace => self.id, :assignee => assignee }
      Task.all_by_workspace(:params => query_options)
    end

    def create_task(*args)
      options = { :workspace => self.id, :assignee => 'me' }
      task = Task.new(options.merge(args.first))
      response = Task.post(nil, nil, task.to_json)
      Task.new(connection.format.decode(response.body))
    end

    def users
      User.all_by_workspace(:params => { :workspace_id => self.id })
    end

  end
end
