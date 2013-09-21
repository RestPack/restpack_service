module RestPack::Service
  class Loader

    def self.load(name)
      require 'require_all'

      require 'restpack_serializer'
      require 'active_support/core_ext'

      restpack_service_name = "restpack_#{name}_service"
      restpack_namespace = "RestPack::#{name.capitalize}"
      service_path = self.get_service_path(caller, restpack_service_name)

      require "#{service_path}/version"
      require "#{service_path}/configuration"
      require_all "#{service_path}/tasks"

      require_service_module 'models', service_path, restpack_namespace
      require_service_module 'serializers', service_path, restpack_namespace
      require_service_module 'commands', service_path, restpack_namespace
    end

    private

    def self.require_service_module(module_name, service_path, restpack_namespace)
      require_all "#{service_path}/#{module_name.downcase}"
      module_sym = module_name.capitalize.to_sym

      existing_module = Object.const_defined?(module_sym) ? Object.const_get(module_sym) : nil

      proxy_module = existing_module || Module.new
      proxy_module.module_eval do
        include Object.const_get("#{restpack_namespace}::Service::#{module_name.capitalize}")
      end

      unless existing_module
        Object.const_set module_sym, proxy_module
      end
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
