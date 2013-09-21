module RestPack::Service
  class Loader
    def self.load(name, dir)
      require 'require_all'

      require 'restpack_serializer'
      require 'active_support/core_ext'

      restpack_service_name = "restpack_#{name}_service"
      restpack_namespace = "RestPack::#{name.capitalize}"
      service_path = "#{dir}/lib/#{restpack_service_name}"

      require "#{service_path}/version"
      require "#{service_path}/configuration"
      require_all "#{service_path}/tasks"

      require_service_module 'models', service_path, restpack_namespace
      require_service_module 'serializers', service_path, restpack_namespace
      require_service_module 'commands', service_path, restpack_namespace
    end

    def self.require_service_module(module_name, service_path, restpack_namespace)
      require_all "#{service_path}/#{module_name.downcase}"
      proxy_module = Module.new
      proxy_module.module_eval do
        include Object.const_get("#{restpack_namespace}::Service::#{module_name.capitalize}")
      end
      Object.const_set module_name.capitalize, proxy_module
    end
  end
end
