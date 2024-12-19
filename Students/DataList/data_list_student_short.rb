require_relative 'data_list'
require_relative 'data_table'


class Data_list_student_short < Data_list
    def initialize(elements)
        super(elements)
        @observers = []
    end

    def add_observer(observer)
        @observers << observer
    end

    def remove_observer(observer)
        @observers.delete(observer)
    end

    def notify
        @observers.each do |observer|
          observer.set_table_params(column_names, data.size)
          observer.set_table_data(get_data)
        end
    end
    
    private

    def column_names
        ["№", "full_name", "git", "contact"]
    end

    def build_row(obj)
        [obj.id, obj.lastname_initials, obj.github, obj.contact]
    end
end