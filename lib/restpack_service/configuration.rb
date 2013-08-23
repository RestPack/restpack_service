module RestPack::Service
  class Configuration
    attr_accessor :db_table_prefix, :application_id

    def initialize
      @db_table_prefix = 'restpack_'
      @application_id = 1
    end

    def prefix_db_table(db_table_name)
      "#{@db_table_prefix}#{db_table_name}".to_sym
    end
  end
end
