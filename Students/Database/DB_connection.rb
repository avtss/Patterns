require 'pg'

class DBConnection
  def initialize(host:, username:, password:, database:, port: 5432)
    @connection = PG.connect(
      host: host,
      user: username,
      password: password,
      dbname: database,
      port: port
    )
  end

  def execute_query(query)
    @connection.exec(query)
  end

  def close
    @connection.close if @connection
  end
end
