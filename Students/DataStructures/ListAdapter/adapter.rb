class Adapter
    def find_student_by_id(id)
      raise NotImplementedError, "Метод не реализован в классе Adapter"
    end
  
    def get_k_n_student_short_list(k, n)
      raise NotImplementedError, "Метод не реализован в классе Adapter"
    end
  
    def add_student(student)
      raise NotImplementedError, "Метод не реализован в классе Adapter"
    end
  
    def update_student_by_id(id, updated_student)
      raise NotImplementedError, "Метод не реализован в классе Adapter"
    end
  
    def delete_student_by_id(id)
      raise NotImplementedError, "Метод не реализован в классе Adapter"
    end
  
    def get_student_count
      raise NotImplementedError, "Метод не реализован в классе Adapter"
    end
  end
  