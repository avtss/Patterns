require_relative './adapter.rb'
require_relative '../students_list.rb'

class Students_list_adapter < Adapter
    def initialize(file_path, strategy)
      @students_list = Students_list.new(file_path, strategy)
    end
  
    def find_student_by_id(id)
      @students_list.find_student_by_id(id)
    end
  
    def get_k_n_student_short_list(k, n)
      @students_list.get_k_n_student_short_list(k, n)
    end
  
    def add_student(student)
      @students_list.add_student(student)
    end
  
    def update_student_by_id(id, updated_student)
      @students_list.update_student_by_id(id, updated_student)
    end
  
    def delete_student_by_id(id)
      @students_list.delete_student_by_id(id)
    end
  
    def get_student_count
      @students_list.get_student_short_count
    end
  end
  