require 'spec_helper'

module Asana
  describe Project do

    before do
      VCR.insert_cassette('projects', :record => :new_episodes)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.all' do
      it 'should return all of the user\'s projects' do
        projects = Project.all
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '.all_by_workspace' do
      it 'should return all projects for the given workspace' do
        workspace = Workspace.all.first
        projects = workspace.projects
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '.create' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        project = Project.new
        lambda { project.save }.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '#tasks' do
      it 'should return all tasks for the given project' do
        projects = Project.all.first
        tasks = projects.tasks
        tasks.must_be_instance_of Array
        tasks.first.must_be_instance_of Task
      end
    end

  end
end
