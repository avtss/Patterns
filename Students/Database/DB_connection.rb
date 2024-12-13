require 'pg'

class DB_Connection
  private_class_method :new
  @@instance = nil

  private 

  def initialize(db_config)
    @connection = PG.connect(db_config)
  end

  public 

  def execute_query(query)
    @connection.exec(query)
  end

  def self.instance(db_config)
    unless @@instance
      @@instance = new(db_config)
    end
    @@instance  
  end
end