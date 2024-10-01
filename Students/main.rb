require_relative 'student'

student1 = Student.new(id: 1, lastname: 'Иванов', firstname: 'Иван', surname: 'Иванович', phone: '123-456')
student2 = Student.new(id: 2, lastname: 'Петров', firstname: 'Петр', surname: 'Петрович', email: 'petr@example.com')
student3 = Student.new(id: 3, lastname: 'Сидоров', firstname: 'Сидор', surname: 'Сидорович', github: 'sidor-github', telegram: '@sidor')
student4 = Student.new(id: 4, lastname: 'Смирнов', firstname: 'Алексей', surname: 'Алексеевич')

student1.display_info
student2.display_info
student3.display_info