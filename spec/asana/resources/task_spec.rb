require 'spec_helper'

module Asana
  describe Task do

    before do
      VCR.insert_cassette('tasks', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.find' do
      it 'should return a single task' do
        task = Task.find(Workspace.all.first.tasks(:me).first.id)
        task.must_be_instance_of Task
      end
    end

    describe '#update' do
      it 'should update the given task with a new name' do
        task = Task.find(Workspace.all.first.tasks(:me).first.id)
        task.update_attribute(:name, 'bar')
        task.name.must_equal 'bar'
      end
    end

    describe '#projects' do
      it 'should return all projects for the given task' do
        task = Project.all.first.tasks.first
        projects = task.projects
        projects.must_be_instance_of Array
        projects.first.must_be_instance_of Project
      end
    end

    describe '#create_story' do
      it 'should create a new story for the given task' do
        task = Project.all.first.tasks.first
        story = task.create_story(:text => 'foo')
        story.must_be_instance_of Story
      end
    end

    describe '#stories' do
      it 'should return all stories for the given task' do
        task = Project.all.first.tasks.first
        stories = task.stories
        stories.must_be_instance_of Array
        stories.first.must_be_instance_of Story
      end
    end

  end
end
