require 'modularize'

module RestPack::Service
  class Loader

    def self.load(gem_name, module_name)
      require 'require_all'

      require 'restpack_serializer'
      require 'active_support/core_ext'

      service_path = self.get_service_path(caller, gem_name)

      require "#{service_path}/version"
      require "#{service_path}/configuration"
      require_all "#{service_path}/tasks"

      Modularize.create "Models"
      Modularize.create "Serializers"
      Modularize.create "Tasks"
      Modularize.create "Jobs"
      Modularize.create "Commands::#{module_name}"

      require_service_module 'models', service_path
      require_service_module 'serializers', service_path
      require_service_module 'commands', service_path
      require_service_module 'jobs', service_path
    end

    private

    def self.require_service_module(module_name, service_path)
      path = "#{service_path}/#{module_name.downcase}"
      require_all(path) if File.directory?(path)
    end

    def self.get_service_path(load_caller, restpack_service_name)
      #Gets the path of the calling service : http://stackoverflow.com/questions/14772381/get-directory-of-file-that-instantiated-a-class-ruby
      source_file = nil
      load_caller.each do |s|
        if(s =~ /(require|require_relative)/)
          source_file = File.dirname(File.expand_path(s.split(':')[0]))
          break
        end
      end
      "#{source_file}/#{restpack_service_name}"
    end
  end
end
