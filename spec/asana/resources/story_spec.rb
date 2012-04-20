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

    describe '#update' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        story = Project.all.first.tasks.first.stories.first
        lambda { story.save }.must_raise ActiveResource::MethodNotAllowed
      end
    end

  end
end
