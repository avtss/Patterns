class ListAdapter
  def initialize(adapter)
    @adapter=adapter
  end

  def find_patient_by_id(id)
    @adapter.find_patient_by_id(id)
  end

  def get_k_n_patient_short_list(k, n)
    @adapter.get_k_n_patient_short_list(k, n)
  end

  def add_patient(patient)
    @adapter.add_patient(patient)
  end

  def update_patient_by_id(id, updated_patient)
    @adapter.update_patient_by_id(id, updated_patient)
  end

  def delete_patient_by_id(id)
    @adapter.delete_patient_by_id(id)
  end

  def get_patient_short_count()
    @adapter.get_patient_short_count()
  end
end