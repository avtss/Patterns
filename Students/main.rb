require_relative 'student'
require_relative 'student_short'
require_relative 'human'

begin
  student1 = Student.new(id: 1, lastname: 'Иванов', firstname: 'Иван', surname: 'Иванович', phone: '+71234567890', email: 'ivan@example.com', telegram: '@ivadsadasn', github: 'https://github.com/ivanov')
  puts student1.to_s
  student2 = Student.new(id: 2, lastname: 'Петров', firstname: 'Петр', surname: 'Петрович', phone: '+79876543210', github: 'https://github.com/petrov') 
  puts student2.to_s
  student3 = Student.new(id: 3, lastname: 'Сидоров', firstname: 'Сидор', surname: 'Сидорович', phone: '+74951234567', email: 'sidor@example.com', github: 'https://github.com/sidorov')
  puts student3.to_s
  student4 = Student.new(id: 4, lastname: 'Смирнов', firstname: 'Алексей', surname: 'Алексеевич', github: 'https://github.com/smirnov')  
  puts student4.to_s

  
  
  
  
rescue ArgumentError => e
  puts e.message
end