require_relative '../../spec_helper'

module Asana
  describe Project do

    before do
      VCR.insert_cassette('projects', :record => :all)
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

    describe '.create' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        project = Project.new
        lambda { project.save }.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '.find' do
      it 'should return a single project' do
        project = Project.find(Project.all.first.id)
        project.must_be_instance_of Project
      end
    end

    describe '#destroy' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        project = Project.all.first
        lambda { project.destroy}.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '#modify' do
      it 'should modify the given project with a new name' do
        project = Workspace.all.first.create_project(:name => 'asana-test-project-foo')
        project.modify(:name => 'asana-test-project-bar').name.must_equal 'asana-test-project-bar'
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
