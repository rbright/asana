module Asana
  class Resource < ActiveResource::Base
    class << self

      def check_prefix_options(options)
      end

      def parent_resources(*resources)
        @parent_resources = resources
      end

      def prefix(options = {})
        if options.any?
          self.site.path + options.map { |k, v| "#{k.to_s.chomp('_id').pluralize}/#{v}" }.join + '/'
        else
          self.site.path
        end
      end

      def prefix_options
        id ? {} : super
      end

      def prefix_source
        if @parent_resources
          self.site.path + @parent_resources.map { |r| "#{r.to_s.pluralize}/:#{r}_id" }.join + '/'
        else
          self.site.path
        end
      end

    end

    def method_not_allowed
      raise ActiveResource::MethodNotAllowed.new(__method__)
    end

  end
end
