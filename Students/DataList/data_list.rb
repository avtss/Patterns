class Data_list

    def initialize(elements)
        @column_names = column_names
        self.data = elements
        @selected=[]
    end

    def select(number)
        element = self.data[number]
        if element && !self.selected.include?(element.id)
            self.selected << number
        end
    end

    def get_selected
        self.selected.dup
    end

    def get_names
        @column_names
    end

    def get_data
        result = [self.get_names]
        index = 1
        selected.each do |selected_index|
          obj = self.data[selected_index]
          row = build_row(index, obj)
          result << row
          index += 1
        end
        Data_table.new(result)
    end

    private

    def column_names
        raise NotImplementedError, "Метод не реализован в классе Data_list"
    end

    protected

    attr_reader :data
    attr_accessor :selected
    
    def data=(data)
        @data = data.map { |element| deep_dup(element) }
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