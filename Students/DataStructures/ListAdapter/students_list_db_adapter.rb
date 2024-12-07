require_relative './adapter.rb'
require_relative '../students_list_db.rb'

class Students_list_db_adapter < Adapter
    def initialize(db_connection)
      @students_list_db = Students_list_DB.instance(db_connection)
    end
  
    def find_student_by_id(id)
      @students_list_db.find_student_by_id(id)
    end
  
    def get_k_n_student_short_list(k, n)
      @students_list_db.get_k_n_student_short_list(k, n)
    end
  
    def add_student(student)
      @students_list_db.add_student(student)
    end
  
    def update_student_by_id(id, updated_student)
      @students_list_db.update_student_by_id(id, updated_student)
    end
  
    def delete_student_by_id(id)
      @students_list_db.delete_student_by_id(id)
    end
  
    def get_student_short_count
      @students_list_db.get_student_short_count
    end
  end
  