require_relative 'data_list'
require_relative 'data_table'


class Data_list_student_short < Data_list

    def initialize(elements)
        super(elements, ["№", "full_name", "git", "contact"])
    end

    private

    def build_row(index, obj)
        [index, obj.lastname_initials, obj.github, obj.contact]
    end
end