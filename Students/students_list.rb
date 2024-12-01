require_relative 'student'
require_relative 'student_short'
require_relative 'DataList/data_list_student_short'

class Students_list
  def initialize(file_path, strategy)
    @file_path = file_path
    @strategy = strategy
    @students = load_from_file
  end

    def load_from_file
      @strategy.load(@file_path).map { |data| Student.new(**data) }
    end
  
    def save_to_file
      @strategy.save(@file_path, @students)
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

    def get_student_short_count
        @students.size
    end
end