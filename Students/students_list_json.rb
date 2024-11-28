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