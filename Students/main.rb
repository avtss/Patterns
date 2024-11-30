require_relative 'student'
require_relative 'student_short'
require_relative 'human'
require_relative 'students_list_json'
require_relative './DataList/data_list'
require_relative './DataList/data_table'
require_relative './DataList/data_list_student_short.rb'

begin
  student1 = Student.new(id: 1, lastname: 'Иванов', firstname: 'Иван', surname: 'Иванович', phone: '+71234567890', email: 'ivan@example.com', telegram: '@ivadsadasn', github: 'https://github.com/ivanov', birth_date: '11.03.2004')
  #puts student1
  student2 = Student.new(id: 2, lastname: 'Петров', firstname: 'Петр', surname: 'Петрович', phone: '+79876543210', github: 'https://github.com/petrov') 
  #puts student2
  student3 = Student.new(id: 2, lastname: 'Сидоров', firstname: 'Сидор', surname: 'Сидорович', phone: '+74951234567', email: 'sidor@example.com', github: 'https://github.com/sidorov')
  #puts student3
  #student4 = Student.from_string("4;Иванов;Иван;Иванович;+79998887700;@ivanov;ivanov@example.com;https://github.com/ivanov;05.08.2003")
  #puts student4

  #Фамилия И.О., https://github.com/example, contact   
  studentshort1=Student_short.from_student(student1)
  studentshort2=Student_short.from_student(student2)
  studentshort3=Student_short.from_string(3, "Петров П.В., https://github.com/avtss, +79991234567")
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
  
  
  list_student_short = Data_list_student_short.new([studentshort1, studentshort2, studentshort3])

# Тестируем выбор студентов
list_student_short.select(0)
puts "Выбранные: #{list_student_short.get_selected}"

list_student_short.select(1)
puts "Выбранные: #{list_student_short.get_selected}"

list_student_short.select(2)
puts "Выбранные: #{list_student_short.get_selected}"

puts list_student_short.get_names

# Получаем данные
puts "Таблица выбранных студентов:"
table = list_student_short.get_data
puts table.to_s

listjson = Students_list_JSON.new('students.json')

puts listjson.sort_by_fullname

puts listjson.count

puts listjson.get_k_n_student_short_list(0, 2).get_data
  

rescue ArgumentError => e
  puts e.message
end