module Asana
  class Resource < ActiveResource::Base
    class << self

      def check_prefix_options(options)
      end

      def custom_method_collection_url(method_name, options = {})
        prefix_options, query_options = split_options(options)
        if method_name
          "#{prefix(prefix_options)}#{collection_name}/#{method_name}.#{format.extension}#{query_string(query_options)}"
        else
          "#{prefix(prefix_options)}#{collection_name}.#{format.extension}#{query_string(query_options)}"
        end
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
