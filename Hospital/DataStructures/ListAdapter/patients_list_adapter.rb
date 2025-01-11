require_relative './adapter.rb'
require_relative '../patients_list.rb'

class PatientsListAdapter < Adapter
    def initialize(strategy, file_path)
      @patients_list = PatientsList.new(strategy, file_path)
      @patients_list.load()
    end
  
    def find_patient_by_id(id)
      @patients_list.find_patient_by_id(id)
    end
  
    def get_k_n_patient_short_list(k, n)
      @patients_list.get_k_n_patient_short_list(k, n)
    end
  
    def add_patient(patient)
      @patients_list.add_patient(patient)
      @patients_list.save
    end
  
    def update_patient_by_id(id, updated_patient)
      @patients_list.update_patient_by_id(id, updated_patient)
      @patients_list.save
    end
  
    def delete_patient_by_id(id)
      @patients_list.delete_patient_by_id(id)
      @patients_list.save
    end
  
    def get_patient_short_count()
      @patients_list.get_patient_short_count
    end
  end
  