require_relative 'student'

begin
  student1 = Student.new(id: 1, lastname: 'Иванов', firstname: 'Иван', surname: 'Иванович', phone: '+71234567890', email: 'ivan@example.com', telegram: '@ivan', github: 'https://github.com/ivanov')
  student2 = Student.new(id: 2, lastname: 'Петров', firstname: 'Петр', surname: 'Петрович', phone: '+79876543210', github: 'https://github.com/petrov') 
  student3 = Student.new(id: 3, lastname: 'Сидоров', firstname: 'Сидор', surname: 'Сидорович', phone: '+74951234567', email: 'sidor@example.com', github: 'https://github.com/sidorov')
  student4 = Student.new(id: 4, lastname: 'Смирнов', firstname: 'Алексей', surname: 'Алексеевич', github: 'https://github.com/smirnov')  

  student1.display_info
  student2.display_info
  student3.display_info
  student4.display_info
rescue ArgumentError => e
  puts e.message
end