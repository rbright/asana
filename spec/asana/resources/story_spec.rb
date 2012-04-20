require 'spec_helper'

module Asana
  describe Story do

    before do
      VCR.insert_cassette('stories', :record => :new_episodes)
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
        story.must_be_instance_of Net::HTTPCreated
      end
    end

    describe '#update' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        story = Project.all.first.tasks.first.stories.first
        lambda { story.save }.must_raise ActiveResource::MethodNotAllowed
      end
    end

  end
end
