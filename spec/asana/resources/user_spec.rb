require 'spec_helper'

module Asana
  describe User do

    before do
      VCR.insert_cassette('users', :record => :new_episodes)
      Asana.configure do |c|
        c.api_key = ENV['ASANA_API_KEY']
      end
    end

    after do
      VCR.eject_cassette
    end

    describe '.all' do
      it 'should return all users for all of the user\'s workspaces' do
        users = User.all
        users.must_be_instance_of Array
        users.first.must_be_instance_of User
      end
    end

    describe '.all_by_workspace' do
      it 'should return all users for the given workspace' do
        user = User.me
        workspace = user.workspaces.first
        users = workspace.users
        users.must_be_instance_of Array
        users.first.must_be_instance_of User
      end
    end

    describe '.find' do
      it 'should return the user with the given ID' do
        user = User.me
        user = User.find(user.id)
        user.wont_be_nil
        user.must_be_instance_of User
      end
    end

    describe '.me' do
      it 'should return the user associated with the given API key' do
        user = User.me
        user.wont_be_nil
        user.must_be_instance_of User
      end
    end

    describe '#save' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        user = User.me
        lambda { user.save }.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '#update' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        user = User.me
        lambda { user.update_attribute(:name, 'foo') }.must_raise ActiveResource::MethodNotAllowed
      end
    end

    describe '#destroy' do
      it 'should raise an ActiveResource::MethodNotAllowed exception' do
        user = User.me
        lambda { user.destroy }.must_raise ActiveResource::MethodNotAllowed
      end
    end

  end
end
