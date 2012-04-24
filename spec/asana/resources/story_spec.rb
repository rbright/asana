require 'spec_helper'

module Asana
  describe Story do

    before do
      VCR.insert_cassette('stories', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.find' do
      it 'should return a single story' do
        story_id = Project.all.first.tasks.first.stories.first.id
        Story.find(story_id).must_be_instance_of Story
      end
    end

    describe '#destroy' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        story = Project.all.first.tasks.first.stories.first
        lambda { story.destroy }.must_raise ActiveResource::MethodNotAllowed
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
