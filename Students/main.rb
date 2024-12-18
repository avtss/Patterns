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
require_relative './DataStructures/Filter/empty_github_filter'
require_relative './DataStructures/Filter/find_by_fullname_filter'
require_relative './DataStructures/Filter/sort_by_fullname_filter'
require_relative './DataStructures/Filter/sort_by_contact_filter'
require_relative './DataStructures/Filter/sort_by_github_filter'
require_relative './StudentsMVC/student_app'
require 'fox16'


include Fox



begin
  yamlstrat=YAML_Strategy.new()
list_adapter1 = List_adapter.new(Students_list_adapter.new(yamlstrat, "students.yaml"))
student1 = Student.from_hash(
  id: 5,
  lastname: "Задикян",
  firstname: "Аветис",
  surname: "Арутюнович",
  phone: "+71234567890",
  email: "avetis@example.com",
  github: "https://github.com/avtss",
  birth_date: "2001-03-25"
)
#list_adapter1.add_student(student5)
#puts "Всего студентов в файле: #{list_adapter1.get_student_short_count}"
#student = list_adapter1.find_student_by_id(1)
#puts "Найден студент: #{student}"
base=Filter.new()
filter=EmptyGithubFilter.new(base)
shrt_list = list_adapter1.get_k_n_student_short_list(1, 10, filter)
puts shrt_list.get_data
puts list_adapter1.get_student_short_count(filter)

db_config = {
  host: 'localhost', user: 'postgres', password: '1q2w34567', dbname: 'student'
}
con = DB_Connection.instance(db_config)

#db_config2 = {
#  host: 'localhost', user: 'postgres', password: '1q2w34567', dbname: 'postgres'
#}

#con2 = DB_Connection.instance(db_config2)

list_adapter2 = List_adapter.new(Students_list_db_adapter.new(con))
#list_adapter2.add_student(student1)

#puts "Всего студентов в БД: #{list_adapter2.get_student_short_count}"
#student = list_adapter2.find_student_by_id(15)
#puts "Найден студент: #{student}"

short_list=list_adapter2.get_k_n_student_short_list(2, 10, filter)

puts short_list.get_data
  if __FILE__ == $0
    FXApp.new do |app|
      StudentApp.new(app)
      app.create
      app.run
    end
  end
rescue ArgumentError => e
  puts e.message
end