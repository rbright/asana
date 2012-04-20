module Asana
  class Workspace < Asana::Resource
    alias :create :method_not_allowed
    alias :destroy :method_not_allowed

    def projects
      Project.all_by_workspace(:params => { :workspace_id => self.id })
    end

    def tasks(assignee)
      query_options = { :workspace => self.id, :assignee => assignee }
      Task.all_by_workspace(:params => query_options)
    end
    end

    def users
      User.all_by_workspace(:params => { :workspace_id => self.id })
    end
  end
end
