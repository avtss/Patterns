require_relative './Entities/student'
require_relative './Entities/student_short'
require_relative './Entities/human'
require_relative './DataList/data_list'
require_relative './DataList/data_table'
require_relative './DataList/data_list_student_short'
require_relative './FileStrategy/json_strategy'
require_relative './FileStrategy/yaml_strategy'
require_relative './DataStructures/student_tree'
require_relative './DataStructures/students_list'
require_relative './Database/DB_connection'
require_relative './DataStructures/ListAdapter/students_list_adapter'
require_relative './DataStructures/ListAdapter/students_list_db_adapter'
require_relative './DataStructures/ListAdapter/list_adapter'
require_relative './DataStructures/Filter/empty_github_filter'
require_relative './DataStructures/Filter/find_by_fullname_filter'
require_relative './DataStructures/Filter/sort_by_fullname_filter'
require_relative './DataStructures/Filter/sort_by_contact_filter'
require_relative './DataStructures/Filter/sort_by_github_filter'
require_relative './StudentsMVC/student_app'
require 'fox16'


include Fox



begin
  if __FILE__ == $0
    FXApp.new do |app|
      StudentApp.new(app)
      app.create
      app.run
    end
  end
rescue ArgumentError => e
  puts e.message
end