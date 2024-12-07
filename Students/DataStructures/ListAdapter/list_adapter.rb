class List_adapter
  def initialize(adapter)
    @adapter=adapter
  end

  def find_student_by_id(id)
    @adapter.find_student_by_id(id)
  end

  def get_k_n_student_short_list(k, n)
    @adapter.get_k_n_student_short_list(k, n)
  end

  def add_student(student)
    @adapter.add_student(student)
  end

  def update_student_by_id(id, updated_student)
    @adapter.update_student_by_id(id, updated_student)
  end

  def delete_student_by_id(id)
    @adapter.delete_student_by_id(id)
  end

  def get_student_short_count
    @adapter.get_student_short_count
  end
end