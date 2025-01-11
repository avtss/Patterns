require 'yaml'
require_relative 'file_strategy'

class YAML_Strategy < File_strategy
  def load(file_path)
    return [] unless File.exist?(file_path)

    file_content = File.read(file_path)
    patient_data = YAML.safe_load(file_content, permitted_classes: [Symbol, Date], symbolize_names: true) || []

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
    File.open(file_path, 'w') { |file| file.write(serialized_data.to_yaml) }
  end
end
