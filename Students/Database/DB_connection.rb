require 'pg'

class DB_Connection
  @instance = nil

  def self.instance(db_config)
    @instance ||= new(db_config)
    @instance
  end

  def self.reset_instance
    @instance = nil
  end

  def execute_query(query)
    @connection.exec(query)
  end

  def close
    @connection.close if @connection
  end

  private_class_method :new

  private

  def initialize(db_config)
    @connection = PG.connect(db_config)
  end
end
