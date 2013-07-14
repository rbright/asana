require_relative '../../spec_helper'

module Asana
  describe Tag do

    before do
      VCR.insert_cassette('tags', :record => :all)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.all' do
      it 'should return all of the user\'s tags' do
        tags = Tag.all
        tags.must_be_instance_of Array
        tags.first.must_be_instance_of Tag
      end
    end

    describe '.create' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        tag = Tag.new
        lambda { tag.save }.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '.find' do
      it 'should return a single tag' do
        tag = Tag.find(Tag.all.first.id)
        tag.must_be_instance_of Tag
      end
    end

    describe '#destroy' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        tag = Tag.all.first
        lambda { tag.destroy}.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '#modify' do
      it 'should modify the given tag with a new name' do
        tag = Workspace.all.first.create_tag(:name => 'asana-test-tag-foo')
        tag.modify(:name => 'asana-test-tag-bar').name.must_equal 'asana-test-tag-bar'
      end
    end

    describe '#tasks' do
      it 'should return all tasks for the given tag' do
        tag = Tag.all.first
        tasks = tag.tasks
        tasks.must_be_instance_of Array
        tasks.first.must_be_instance_of Task
      end
    end

  end
end
