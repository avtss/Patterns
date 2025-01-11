require_relative 'data_list'
require_relative 'data_table'


class DataListPatientShort < DataList
    
    private

    def column_names
        ["№", "full_name", "phone", "card_number"]
    end

    def build_row(obj)
        [obj.id, obj.lastname_initials, obj.phone, obj.card_number]
    end
end