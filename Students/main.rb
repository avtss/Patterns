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

  sttree=Student_tree.new()
  student1 = Student.new(
  id: 1,
  lastname: "Иванов",
  firstname: "Иван",
  surname: "Иванович",
  phone: "+79991234567",
  telegram: "@ivanov_ivan",
  email: "ivanov.ivan@example.com",
  github: "https://github.com/ivanov-ivan",
  birth_date: "2000-01-15"
)

student2 = Student.new(
  id: 2,
  lastname: "Петров",
  firstname: "Петр",
  surname: "Петрович",
  phone: "+79997654321",
  telegram: "@petrov_petr",
  email: "petrov.petr@example.com",
  github: "https://github.com/petrov-petr",
  birth_date: "1999-05-10"
)
student3 = Student.from_string("3; Сидоров; Сергей; Сергеевич; +79991112233; @sidorov_sergey; sidorov.sergey@example.com; https://github.com/sidorov-sergey; 1998-11-20")

student4 = Student.from_hash(
  id: 4,
  lastname: "Кузнецов",
  firstname: "Николай",
  surname: "Николаевич",
  phone: "+79994445566",
  telegram: "@kuznetsov_nikolay",
  email: "kuznetsov.nikolay@example.com",
  github: "https://github.com/kuznetsov-nikolay",
  birth_date: "2001-03-25"
)
  sttree.insert(student1)
  sttree.insert(student2)
  sttree.insert(student3)
  sttree.insert(student4)
  puts sttree.select{|s| s.lastname=="Кузнецов"}


  
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

short_list=list_adapter2.get_k_n_student_short_list(2, 10)
puts short_list.get_data
rescue ArgumentError => e
  puts e.message
end