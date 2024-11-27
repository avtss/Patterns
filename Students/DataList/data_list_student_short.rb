require_relative 'data_list'
require_relative 'data_table'


class Data_list_student_short < Data_list

    def get_names
        ["№", "full_name", "git", "contact"]
    end

    def get_data
        index = 1
        result = [self.get_names]
        selected = self.get_selected
        selected.each do |selected_index|
            obj = self.data[selected_index]
            row = [index, obj.lastname_initials, obj.github, obj.contact]
            result.append(row)
            index += 1
        end
        Data_table.new(result)
    end
end