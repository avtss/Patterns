require_relative '../Models/patient.rb'
require_relative '../Models/patient_short.rb'
require_relative './DataList/data_list_patient_short.rb'

class PatientsList
  def initialize(strategy, file_path)
    @strategy = strategy
    @patients=[]
    @file_path = file_path
  end

  def load()
    @patients = @strategy.load(@file_path)
  end
  
    def save()
      @strategy.save(@file_path, @patients)
    end

    def find_patient_by_id(id)
        @patients.find { |patient| patient.id == id }
    end

    def get_k_n_patient_short_list(k, n)
      start_index = (k - 1) * n
      end_index = start_index + n - 1
    
      short_patients = @patients[start_index..end_index] || []

      short_patients = short_patients.map { |patient| PatientShort.from_patient(patient) }
      selected_list = DataListPatientShort.new(short_patients)
      
      short_patients.each_with_index { |_, ind| selected_list.select(ind) }
      selected_list
    end

      def sort_by_fullname
        @patients.sort_by!(&:fullname)
      end

      def add_patient(patient)
        new_id = (@patients.map(&:id).max || 0) + 1
        patient.id = new_id
        if @patients.any? {|st| st==patient}
          raise ArgumentError, "Студент с такими контактами уже существует"
        end
        @patients << patient
      end
    
      def update_patient_by_id(id, updated_patient)
        if @patients.any? {|st| st==updated_rpatient}
          raise ArgumentError, "Студент с такими контактами уже существует"
        end
        index = @patients.find_index { |patient| patient.id == id }
        return false unless index
    
        updated_patient.id = id
        @patients[index] = updated_patient
        true
      end

      def delete_patient_by_id(id)
        @patients.reject! { |patient| patient.id == id }
    end

    def get_patient_short_count()
      @patients.size
    end
end