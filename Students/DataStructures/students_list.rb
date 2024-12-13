require_relative '../Entities/student.rb'
require_relative '../Entities/student_short.rb'
require_relative '../DataList/data_list_student_short.rb'

class Students_list
  def initialize(strategy)
    @strategy = strategy
    @students=[]
  end

  def load(file_path)
    data = @strategy.load(file_path)
    @students = data.map { |student_data| Student.new(**student_data) }
  end
  
    def save(file_path)
      @strategy.save(file_path, @students)
    end

    def find_student_by_id(id)
        @students.find { |student| student.id == id }
    end

    def get_k_n_student_short_list(k, n, existing_data_list = nil)
      start_index = (k - 1) * n
      end_index = start_index + n - 1
    
      short_students = @students[start_index..end_index] || []
      short_students = short_students.map { |student| Student_short.from_student(student) }
    
      if existing_data_list
        existing_data_list.update(short_students)
        selected_list = existing_data_list
      else
        selected_list = Data_list_student_short.new(short_students)
      end
      short_students.each_with_index { |_, ind| selected_list.select(ind) }
      selected_list
    end

      def sort_by_fullname
        @students.sort_by!(&:fullname)
      end

      def add_student(student)
        new_id = (@students.map(&:id).max || 0) + 1
        student.id = new_id
        @students.any? {|st| st.same_contacts?(student)}
        @students << student
      end
    
      def update_student_by_id(id, updated_student)
        index = @students.find_index { |student| student.id == id }
        return false unless index
    
        updated_student.id = id
        @students[index] = updated_student
        true
      end

      def delete_student_by_id(id)
        @students.reject! { |student| student.id == id }
    end

    def get_student_short_count
        @students.size
    end
end