require 'spec_helper'

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

    describe '#update' do
      it 'should update the given project with a new name' do
        project = Project.all.last
        #project.name.wont_equal 'foo'
        project.update_attribute(:name, 'foo')
        project.name.must_equal 'foo'
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
