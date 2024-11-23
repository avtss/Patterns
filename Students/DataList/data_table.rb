class Data_table
  def initialize(data)
    self.data = data
  end

  def get_element(num_of_row,num_of_column)
    self.data[num_of_row][num_of_column]
  end
  
  def row_count
    self.data.size
  end

  def col_count
    if self.data.empty?
        return 0
    end
    self.data[0].size
  end

  def to_s 
    self.data.inspect
  end

  private

  attr_reader :data

  def data=(data)
    unless data.is_a?(Array) && data.all? {|row| row.is_a?(Array)}
        raise ArgumentError, "Данные должны быть в виде двумерного массива"
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

    @data = data.map{ |row| row.map { |element| deep_dup(element) }}
  end
end
