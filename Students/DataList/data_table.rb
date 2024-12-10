class Data_table
  def initialize(data)
    self.data = data
  end

  def get_element(num_of_row, num_of_column)
    deep_dup(data)[num_of_row][num_of_column]
  end
  
  def row_count
    data.size
  end

  def col_count
    return 0 if data.empty?

    data[0].size
  end

  def to_s 
    data.inspect
  end

  private

  attr_reader :data

  def data=(data)
    unless data.is_a?(Array) && data.all? { |row| row.is_a?(Array) }
      raise ArgumentError, "Данные должны быть в виде двумерного массива"
    end
    @data = deep_dup(data)
  end

  def deep_dup(element)
    if element.is_a?(Array)
      element.map { |sub_element| deep_dup(sub_element) }
    else
      begin
        element.dup
      rescue
        element
      end
    end
  end
end
