require_relative '../../spec_helper'

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

    describe '#modify' do
      it 'should modify the given task with a new name' do
        task = Workspace.all.first.create_task(:name => 'asana-test-foo', :assignee => 'me')
        task.modify(:name => 'asana-test-bar').name.must_equal 'asana-test-bar'
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

    describe '#add_project' do
      it 'should add the project to the given task' do
        task = Workspace.all.first.create_task(:name => 'asana-test-task-add-project', :assignee => 'me')
        project = Workspace.all.first.create_project(:name => 'asana-test-task-parent-project')
        task.add_project project.id
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

    describe '#create_subtask' do
      it 'should create a new subtask for the given task' do
        task = Project.all.first.tasks.first
        subtask = task.create_subtask(:name => 'asana-test-subtask', :assignee => 'me')
        subtask.must_be_instance_of Task
        subtask.parent.must_be_instance_of Task
        subtask.parent.id.must_equal task.id
      end
    end

    describe '#subtasks' do
      it 'should return all subtasks for the given task' do
        task = Project.all.first.tasks.first
        subtasks = task.subtasks
        subtasks.must_be_instance_of Array
        subtasks.first.must_be_instance_of Task
        subtasks.first.parent.must_be_instance_of Task
        subtasks.first.parent.id.must_equal task.id
      end
    end

  end
end
