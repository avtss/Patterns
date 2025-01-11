require_relative './adapter.rb'

class PatientsListDBAdapter < Adapter
  def initialize(db_config)
    @db = DB_Connection.instance(db_config)
  end
  
  def find_patient_by_id(id)
    result = @db.execute_query("SELECT * FROM patient WHERE id = #{id}")
    return nil if result.ntuples == 0
    row = result[0]
  
    Patient.from_hash(
      id: row['id'],
      lastname: row['lastname'],
      firstname: row['firstname'],
      surname: row['surname'],
      phone: row['phone'],
      birth_date: row['birthdate'],
      diagnosis: row['diagnosis'],
      doctor_id: row['doctor_id']
    )
  end
  
  def get_k_n_patient_short_list(k, n)
    start_index = (k - 1) * n + 1
    end_index = start_index + n - 1
    query = "
      SELECT * FROM patient
      WHERE id BETWEEN #{start_index} AND #{end_index}
    "
    result = @db.execute_query(query)
    patients = result.map do |row|
      Patient.from_hash(
        id: row['id'],
        lastname: row['lastname'],
        firstname: row['firstname'],
        surname: row['surname'],
        phone: row['phone'],
        birth_date: row['birthdate'],
        diagnosis: row['diagnosis'],
        doctor_id: row['doctor_id']
      )
    end
  
    short_patients = patients.map { |patient| PatientShort.from_patient(patient) }
  
    selected_list = DataListPatientShort.new(short_patients)
    short_patients.each_with_index { |_, index| selected_list.select(index) }
    selected_list
  end
  
  def add_patient(lastname, firstname, surname, birth_date, phone, card_number, diagnosis, doctor_id)
    begin
      query = "
        INSERT INTO patient (lastname, firstname, surname, birthdate, phone, card_number, diagnosis, doctor_id)
        VALUES ('#{lastname}', '#{firstname}', '#{surname}', 
                '#{birth_date}', 
                #{phone.nil? ? 'NULL' : "'#{phone}'"},
                '#{card_number}', '#{diagnosis}', #{doctor_id})
      "
      @db.execute_query(query)
    rescue PG::UniqueViolation => e
      raise ArgumentError, "Пациент с такими контактами уже существует"
    end
  end

  def update_patient_by_id(id, lastname, firstname, surname, birth_date, phone, card_number, diagnosis, doctor_id)
    begin
      query = "
        UPDATE patient
        SET lastname = '#{lastname}',
            firstname = '#{firstname}',
            surname = '#{surname}',
            phone = #{phone.nil? ? 'NULL' : "'#{phone}'"},
            birthdate = #{birth_date.nil? ? 'NULL' : "'#{birth_date}'"},
            card_number = #{card_number.nil? ? 'NULL' : "'#{card_number}'"},
            diagnosis = #{diagnosis.nil? ? 'NULL' : "'#{diagnosis}'"},
            doctor_id = #{doctor_id.nil? ? 'NULL' : "#{doctor_id}"}
        WHERE id = #{id}
      "
      @db.execute_query(query)
    rescue PG::UniqueViolation => e
      raise ArgumentError, "Пациент с такими контактами уже существует"
    end
  end

  def delete_patient_by_id(id)
    @db.execute_query("DELETE FROM patient WHERE id = #{id}")
  end

  def get_patient_short_count()
    query = 'SELECT * FROM patient'
    result = @db.execute_query(query)
  
    patients = result.map do |row|
      Patient.from_hash(
        id: row['id'],
        lastname: row['last_name'],
        firstname: row['first_name'],
        surname: row['surname'],
        phone: row['phone'],
        email: row['email'],
        birth_date: row['birth_date']
      )
    end
  
    patients.size
  end
end
