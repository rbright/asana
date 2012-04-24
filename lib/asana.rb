require 'active_resource'

require 'asana/config'
require 'asana/version'

require 'asana/resources/project'
require 'asana/resources/story'
require 'asana/resources/task'
require 'asana/resources/user'
require 'asana/resources/workspace'

module Asana
  extend Config
end
