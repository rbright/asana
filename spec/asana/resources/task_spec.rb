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
