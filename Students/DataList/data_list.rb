class Data_list

    def initialize(elements)
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
        raise NotImplementedError, "Метод не реализован в классе Data_list"
    end

    def get_data
        raise NotImplementedErroe, "Метод не реализован в классе Data_list"
    end

    private

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