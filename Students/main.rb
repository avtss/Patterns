require_relative 'student'

student1 = Student.new(id: 1, lastname: 'Иванов', firstname: 'Иван', surname: 'Иванович', phone: '123-456', telegram: '@ivan', email: 'ivan@example.com', github: 'ivan-github')
student2 = Student.new(id: 2, lastname: 'Петров', firstname: 'Петр', surname: 'Петрович', phone: '987-654', telegram: '@petr', email: 'petr@example.com', github: 'petr-github')
student3 = Student.new(id: 3, lastname: 'Сидоров', firstname: 'Сидор', surname: 'Сидорович', phone: '555-123', telegram: '@sidor', email: 'sidor@example.com', github: 'sidor-github')

student1.display_info
student2.display_info
student3.display_info