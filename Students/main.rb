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
require_relative './DataStructures/students_list_DB'
require 'pg'


begin
  student1 = Student.new(id: 1, lastname: 'Иванов', firstname: 'Иван', surname: 'Иванович', phone: '+71234567890', email: 'ivan@example.com', telegram: '@ivadsadasn', github: 'https://github.com/ivanov', birth_date: '11-03-2004')
  #puts student1
  student2 = Student.new(id: 2, lastname: 'Петров', firstname: 'Петр', surname: 'Петрович', phone: '+79876543210', github: 'https://github.com/petrov', birth_date: '05-08-2003') 
  #puts student2
  student3 = Student.new(id: 3, lastname: 'Сидоров', firstname: 'Сидор', surname: 'Сидорович', phone: '+74951234567', email: 'sidor@example.com', github: 'https://github.com/sidorov', birth_date: '12-11-2001')
  #puts student3
  student4 = Student.from_string("4;Иванов;Иван;Иванович;+79998887700;@ivanov;ivanov@example.com;https://github.com/ivanov;05-08-2003")
  #puts student4

  #Фамилия И.О., https://github.com/example, contact   
  #studentshort1=Student_short.from_student(student1)
  #studentshort2=Student_short.from_student(student2)
  #studentshort3=Student_short.from_string(3, "Петров П.В., https://github.com/avtss, +79991234567")
  #puts studentshort1
  
  #puts studentshort2

  #data_table=Data_table.new([[1, 2, 3], [4, 5, 6], [7, 8, 9]])
  #puts data_table.get_element(0, 0)
  #puts data_table.get_element(1, 2)
  #puts data_table.row_count

  #data_list = Data_list.new([student1, student2, student3])
  #data_list.select(0) 
  #puts "Выбранные: #{data_list.get_selected}"
  #data_list.select(2)
  #puts "Выбранные: #{data_list.get_selected}"
  
  
  #list_student_short = Data_list_student_short.new([studentshort1, studentshort2, studentshort3])

# Тестируем выбор студентов
#list_student_short.select(0)
#puts "Выбранные: #{list_student_short.get_selected}"

#list_student_short.select(1)
#puts "Выбранные: #{list_student_short.get_selected}"

#list_student_short.select(2)
#puts "Выбранные: #{list_student_short.get_selected}"

#puts list_student_short.get_names

# Получаем данные
#puts "Таблица выбранных студентов:"
#table = list_student_short.get_data
#puts table.to_s

#tree = StudentTree.new

#tree.insert(student1)
#tree.insert(student2)
#tree.insert(student3)

#tree.each { |student| puts student }


#student = tree.find { |s| s.birth_date == "12.11.2001" }
#puts student

#tree = StudentTree.new

#tree.insert(student1)
#tree.insert(student2)
#tree.insert(student3)

#tree.each { |student| puts student }


#student = tree.find { |s| s.birth_date == "12.11.2001" }
#puts student


#students_list = Students_list_YAML.new('students.yaml')
#students_list.add_student(student3)

#puts "Количество студентов: #{students_list.count}"

#puts "Отсортированные по имени: #{students_list.sort_by_fullname}"

#students_list_json = Students_list.new('students.json', JSON_Strategy.new)

#puts "Количество студентов в JSON: #{students_list_json.count}"

#students_list_yaml = Students_list.new('students.yaml', YAML_Strategy.new)

#puts "Отсортированные по фио студенты в YAML: #{students_list_yaml.sort_by_fullname}"

con= DBConnection.new(host: 'localhost', username: 'postgres', password: '1q2w34567', database: 'student')
#result = con.execute_query('SELECT * FROM student')
#  result.each do |row|
#    puts row
#  end
#con.close
#full_data = {
#  id: '1',
#  lastname: 'Иванов',
#  firstname: 'Иван',
#  surname: 'Иванович',
#  phone: '+71234567890',
#  email: 'ivan@example.com',
#  telegram: '@ivanov',
#  github: 'https://github.com/ivanov',
#  birth_date: '2004-03-11'
#}
#student1 = Student.from_hash(full_data)


students_list = Students_list_DB.instance(con)


student = Student.new(
  lastname: 'Задикян',
  firstname: 'Аветис',
  surname: 'Арутюнович',
  phone: '+79881834551',
  email: 'avetis@example.com',
  telegram: '@avetissss',
  github: 'https://github.com/avtss',
  birth_date: '2004-08-05'
)

#students_list.add_student(student)
#puts "Количество студентов: #{students_list.get_student_count}"

#found_student = students_list.find_student_by_id(11)
#puts "Нашли студента с id 11: #{found_student.to_s}"

updated_student = Student.new(
  lastname: 'Эксузян',
  firstname: 'Аветис',
  surname: 'Арутюнович',
  phone: '+79881834551',
  email: 'avetis@example.com',
  telegram: '@avetissss',
  github: 'https://github.com/avtss',
  birth_date: '2004-08-05'
)
#students_list.update_student_by_id(29, updated_student)

puts students_list.get_k_n_student_short_list(2, 5).get_data

#students_list.delete_student_by_id(20)

#puts "Количество студентов: #{students_list.get_student_count}"
rescue ArgumentError => e
  puts e.message
end