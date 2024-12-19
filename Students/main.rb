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
require_relative './DataStructures/Filter/sort_by_fullname_filter'
require_relative './DataStructures/Filter/find_by_git_filter'
require_relative './DataStructures/Filter/find_by_phone_filter'
require_relative './DataStructures/Filter/find_by_telegram_filter'
require_relative './Views/student_app'
require_relative './Controllers/student_list_controller'
require 'fox16'


include Fox



begin
  db_config = { host: 'localhost', user: 'postgres', password: '1q2w34567', dbname: 'student' }
  app = FXApp.new
  view = StudentApp.new(app, db_config)
  app.create
  app.run
rescue ArgumentError => e
  puts e.message
end