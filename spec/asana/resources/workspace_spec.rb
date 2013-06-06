require_relative '../../spec_helper'

module Asana
  describe Workspace do

    before do
      VCR.insert_cassette('workspaces', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.all' do
      it 'should return all of the user\'s workspaces' do
        workspaces = Workspace.all
        workspaces.must_be_instance_of Array
        workspaces.first.must_be_instance_of Workspace
      end
    end

    describe '.find' do
      it 'should return a single workspace' do
        workspace = Workspace.find(Workspace.all.first.id)
        workspace.must_be_instance_of Workspace
      end
    end

    describe '#create' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        workspace = Workspace.new
        lambda { workspace.save }.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '#create_task' do
      it 'should create a new task for the given workspace' do
        workspace = Workspace.all.first
        task = workspace.create_task(:name => 'asana-test-task', :assignee => 'me')
        task.must_be_instance_of Task
      end
    end

    describe '#create_project' do
      it 'should create a new project for the given workspace' do
        workspace = Workspace.all.first
        project = workspace.create_project(:name => 'asana-test-project')
        project.must_be_instance_of Project
      end
    end

    describe '#update' do
      it 'should update the given workspace with a new name' do
        workspace = Workspace.all.last
        workspace.update_attribute(:name, 'foo')
        workspace.name.must_equal 'foo'
      end
    end

    describe '#destroy' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        workspace = Workspace.all.first
        lambda { workspace.destroy }.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '#projects' do
      it 'should return all projects for the given workspace' do
        workspace = Workspace.all.first
        projects = workspace.projects
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '#tags' do
      it 'should return all tags for the given workspace' do
        workspace = Workspace.all.first
        tags = workspace.tags
        tags.must_be_instance_of Array
        tags.first.must_be_instance_of Tag
      end
    end

    describe '#tasks' do
      it 'should return all tasks for the given workspace' do
        workspace = Workspace.all.first
        user = User.all.first
        tasks = workspace.tasks(user.id)
        tasks.must_be_instance_of Array
        tasks.first.must_be_instance_of Task
      end
    end

    describe '#users' do
      it 'should return all users for the given workspace' do
        workspace = Workspace.all.first
        users = workspace.users
        users.must_be_instance_of Array
        users.first.must_be_instance_of User
      end
    end

  end
end
