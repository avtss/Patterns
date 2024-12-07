require_relative './Entities/student'
require_relative './Entities/student_short'
require_relative './Entities/human'
require_relative './DataList/data_list'
require_relative './DataList/data_table'
require_relative './DataList/data_list_student_short'
require_relative './FileStrategy/json_strategy'
require_relative './FileStrategy/yaml_strategy'
require_relative './DataStructures/student_tree'
require_relative './DataStructures/students_list'
require_relative './Database/DB_connection'
require_relative './DataStructures/ListAdapter/students_list_adapter'
require_relative './DataStructures/ListAdapter/students_list_db_adapter'
require_relative './DataStructures/ListAdapter/list_adapter'



begin
  
list_adapter1 = List_adapter.new(Students_list_adapter.new('students.yaml', YAML_Strategy.new))

puts "Всего студентов в файле: #{list_adapter1.get_student_short_count}"
student = list_adapter1.find_student_by_id(1)
puts "Найден студент: #{student}"

db_config = {
  host: 'localhost', user: 'postgres', password: '1q2w34567', dbname: 'student'
}
con = DB_Connection.instance(db_config)

list_adapter2 = List_adapter.new(Students_list_db_adapter.new(con))

puts "Всего студентов в БД: #{list_adapter2.get_student_short_count}"
student = list_adapter2.find_student_by_id(1)
puts "Найден студент: #{student}"
rescue ArgumentError => e
  puts e.message
end