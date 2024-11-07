require_relative 'student'
require_relative 'student_short'
require_relative 'human'

begin
  student1 = Student.new(id: 1, lastname: 'Иванов', firstname: 'Иван', surname: 'Иванович', phone: '+71234567890', email: 'ivan@example.com', telegram: '@ivadsadasn', github: 'https://github.com/ivanov')
  puts student1
  student2 = Student.new(id: 2, lastname: 'Петров', firstname: 'Петр', surname: 'Петрович', phone: '+79876543210', github: 'https://github.com/petrov') 
  puts student2
  student3 = Student.new(id: 3, lastname: 'Сидоров', firstname: 'Сидор', surname: 'Сидорович', phone: '+74951234567', email: 'sidor@example.com', github: 'https://github.com/sidorov')
  puts student3
  student4 = Student.from_string("4;Иванов;Иван;Иванович;+79998887700;@ivanov;ivanov@example.com;https://github.com/ivanov")
  puts student4

  #Фамилия И.О., https://github.com/example, contact   
  studentshort1=Student_short.from_string(5, "Петров П.В., https://github.com/avtss, +79991234567")
  puts studentshort1
  studentshort2=Student_short.from_student(student1)
  puts studentshort2
rescue ArgumentError => e
  puts e.message
end