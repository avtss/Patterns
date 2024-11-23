class Data_table
  def initialize(data)
    unless data.is_a?(Array) && data.all? {|e| e.is_a?(Array)}
      raise ArgumentError, "Data is not an 2d Array"
    end
    @data = data
  end

  def get_element(num_of_row,num_of_column)
    @data[num_of_row][num_of_column]
  end
  
  def count_of_rows
    @data.count
  end

  def count_of_columns
    @data[0].count
  end

  def to_s 
    @data.inspect
  end
end