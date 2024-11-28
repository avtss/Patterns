require 'json'
require_relative 'student'
require_relative 'student_short'
require_relative 'DataList/data_list_student_short'

class Students_list_JSON
    def initialize(file_path)
        @file_path = file_path
        @students = []
        load_from_file
    end

    def load_from_file
        if File.exist?(@file_path)
          file_content = File.read(@file_path)
          student_data = JSON.parse(file_content, symbolize_names: true)
          @students = student_data.map { |data| Student.new(**data) }
        else
          @students = []
        end
    end

    def save_to_file
        serialized_data = @students.map do |student|
          {
            id: student.id,
            lastname: student.lastname,
            firstname: student.firstname,
            surname: student.surname,
            phone: student.phone,
            telegram: student.telegram,
            email: student.email,
            github: student.github,
            birth_date: student.birth_date
          }
        end
        File.open(@file_path, 'w') do |file|
            file.write(JSON.pretty_generate(serialized_data))
        end
      end

      def find_student_by_id(id)
        @students.find { |student| student.id == id }
      end

      def get_k_n_student_short_list(k, n, existing_data_list = nil)
        start_index = (k - 1) * n
        end_index = start_index + n - 1
        short_students = @students[start_index..end_index] || []
        return existing_data_list || Data_list_student_short.new([]) if short_students.empty?
        short_students = short_students.map { |student| Student_short.from_student(student) }
      
        if existing_data_list
          existing_data_list.data = short_students
          short_students.each_with_index { |_, ind| existing_data_list.select(ind) }
          return existing_data_list
        end
        selected_list = Data_list_student_short.new(short_students)
        short_students.each_with_index { |_, ind| selected_list.select(ind) }
        selected_list
      end
      

      def sort_by_fullname
        @students.sort_by!(&:fullname)
      end

      def add_student(student)
        new_id = (@students.map(&:id).max || 0) + 1
        student.id = new_id
        @students << student
        save_to_file
      end

      def update_student_by_id(id, updated_student)
        index = @students.find_index { |student| student.id == id }
        return false unless index
    
        updated_student.id = id
        @students[index] = updated_student
        save_to_file
        true
    end

    def delete_student_by_id(id)
        @students.reject! { |student| student.id == id }
        save_to_file
    end

    def count
        @students.size
    end
end

student_list = Students_list_JSON.new("students.json")


student1 = Student.new(
  lastname: "Петров",
  firstname: "Петр",
  surname: "Петрович",
  id: 2,
  phone: "+79222222222",
  telegram: "@petrrrrrr",
  email: "petrov@example.com",
  github: "https://github.com/petrov",
  birth_date: "02.02.2002"
)

student2 = Student.new(
  lastname: "Сидоров",
  firstname: "Сидор",
  surname: "Сидорович",
  id: 3,
  phone: "+79333333333",
  telegram: "@sidorrrrr",
  email: "sidorov@example.com",
  github: "https://github.com/sidorov",
  birth_date: "03.03.2003"
)

#student_list.add_student(student1)
#student_list.add_student(student2)

puts student_list.find_student_by_id(1)

short_list = student_list.get_k_n_student_short_list(1, 2)
puts "Краткий список студентов:"
puts short_list.get_data

puts student_list.sort_by_fullname

student3 = Student.new(
  lastname: "Задикян",
  firstname: "Аветис",
  surname: "Арутюнович",
  id: 4,
  phone: "+79222222222",
  telegram: "@zadikyannnn",
  email: "zadikyann@example.com",
  github: "https://github.com/avtss",
  birth_date: "05.08.2004"
)
#student_list.update_student_by_id(4, student3)
student_list.delete_student_by_id(4)

puts student_list.count
