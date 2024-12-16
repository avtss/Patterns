require_relative '../Entities/student.rb'
require_relative '../Entities/student_short.rb'
require_relative '../DataList/data_list_student_short.rb'

class Students_list
  def initialize(strategy, file_path)
    @strategy = strategy
    @students=[]
    @file_path = file_path
  end

  def load()
    data = @strategy.load(@file_path)
    @students = data.map { |student_data| Student.new(**student_data) }
  end
  
    def save()
      @strategy.save(@file_path, @students)
    end

    def find_student_by_id(id)
        @students.find { |student| student.id == id }
    end

    def get_k_n_student_short_list(k, n, filter=nil)
      start_index = (k - 1) * n
      end_index = start_index + n - 1
    
      short_students = @students[start_index..end_index] || []
      short_students = filter.apply_filter(short_students) if filter

      short_students = short_students.map { |student| Student_short.from_student(student) }
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
        if @students.any? {|st| st==student}
          raise ArgumentError, "Студент с такими контактами уже существует"
        end
        @students << student
      end
    
      def update_student_by_id(id, updated_student)
        if @students.any? {|st| st==updated_rstudent}
          raise ArgumentError, "Студент с такими контактами уже существует"
        end
        index = @students.find_index { |student| student.id == id }
        return false unless index
    
        updated_student.id = id
        @students[index] = updated_student
        true
      end

      def delete_student_by_id(id)
        @students.reject! { |student| student.id == id }
    end

    def get_student_short_count(filter = nil)
      filtered_students = filter ? filter.apply_filter(@students) : @students
      filtered_students.size
    end
end