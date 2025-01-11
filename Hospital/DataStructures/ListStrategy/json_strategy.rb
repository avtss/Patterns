require 'json'
require_relative 'file_strategy'

class JSON_Strategy < FileStrategy
  def load(file_path)
    return [] unless File.exist?(file_path)

    file_content = File.read(file_path)
    patient_data = JSON.parse(file_content, symbolize_names: true)

    patient_data.map { |data| Patient.new(**data) }
  end

  def save(file_path, data)
    serialized_data = data.map do |patient|
      {
        id: patient.id,
        lastname: patient.lastname,
        firstname: patient.firstname,
        surname: patient.surname,
        phone: patient.phone,
        card_number: patient.card_number
        birth_date: patient.birth_date
        diagnosis: patient.diagnosis
      }
    end
    File.open(file_path, 'w') { |file| file.write(JSON.pretty_generate(serialized_data)) }
  end
end
