class Adapter
  def find_patient_by_id(id)
    raise NotImplementedError, "Метод не реализован в классе Adapter"
  end

  def get_k_n_patient_short_list(k, n)
    raise NotImplementedError, "Метод не реализован в классе Adapter"
  end

  def add_patient(patient)
    raise NotImplementedError, "Метод не реализован в классе Adapter"
  end

  def update_patient_by_id(id, updated_patient)
    raise NotImplementedError, "Метод не реализован в классе Adapter"
  end

  def delete_patient_by_id(id)
    raise NotImplementedError, "Метод не реализован в классе Adapter"
  end

  def get_patient_count()
    raise NotImplementedError, "Метод не реализован в классе Adapter"
  end
end
