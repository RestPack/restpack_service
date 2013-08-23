module RestPack::Service
  class Configuration
    attr_accessor :application_id

    def initialize
      @application_id = 1
    end
  end
end
