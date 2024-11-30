require 'yaml'
require_relative 'students_list.rb'

class Students_list_YAML < Students_list
  def load_from_file
    if File.exist?(@file_path)
      file_content = File.read(@file_path)
      student_data = YAML.safe_load(file_content, permitted_classes: [Symbol], symbolize_names: true) || []
      @students = student_data.map { |data| Student.new(**data) }
    else
      @students = []
    end
  end  

  def save_to_file
    serialized_data = @students.map do |student|
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
    File.open(@file_path, 'w') { |file| file.write(serialized_data.to_yaml) }
  end
end
