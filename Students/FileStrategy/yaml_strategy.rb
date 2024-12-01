require 'yaml'
require_relative 'file_strategy'

class YAML_Strategy < FileStrategy
  def load(file_path)
    return [] unless File.exist?(file_path)

    file_content = File.read(file_path)
    YAML.safe_load(file_content, permitted_classes: [Symbol, Date], symbolize_names: true) || []
  end

  def save(file_path, data)
    serialized_data = data.map do |student|
      {
        id: student.id,
        lastname: student.lastname,
        firstname: student.firstname,
        surname: student.surname,
        phone: student.phone,
        telegram: student.telegram,
        email: student.email,
        github: student.github,
        birth_date: student.birth_date
      }
    end
    File.open(file_path, 'w') { |file| file.write(serialized_data.to_yaml) }
  end
end
