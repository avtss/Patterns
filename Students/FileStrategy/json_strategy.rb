require 'json'
require_relative 'file_strategy'

class JSON_Strategy < File_strategy
  def load(file_path)
    return [] unless File.exist?(file_path)

    file_content = File.read(file_path)
    JSON.parse(file_content, symbolize_names: true)
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
    File.open(file_path, 'w') { |file| file.write(JSON.pretty_generate(serialized_data)) }
  end
end
