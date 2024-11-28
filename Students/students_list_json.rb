require 'json'
require_relative 'student'
require_relative 'student_short'
require_relative 'DataList/data_list_student_short'

class Students_list_JSON
    def initialize(file_path)
        @file_path = file_path
        @students = []
        load_from_file
    end

    def load_from_file
        if File.exist?(@file_path)
          file_content = File.read(@file_path)
          student_data = JSON.parse(file_content, symbolize_names: true)
          @students = student_data.map { |data| Student.new(**data) }
        else
          @students = []
        end
    end
end

student_list = Students_list_JSON.new("students.json")
puts student_list.inspect
    