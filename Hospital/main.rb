require_relative './Models/patient'
require_relative './Models/patient_short'
require_relative './Models/human'
require_relative './DataStructures/DataList/data_list'
require_relative './DataStructures/DataList/data_table'
require_relative './DataStructures/DataList/data_list_patient_short'
require_relative './DataStructures/ListStrategy/json_strategy'
require_relative './DataStructures/ListStrategy/yaml_strategy'
require_relative './DataStructures/patients_list'
require_relative './Database/DB_connection'
require_relative './DataStructures/ListAdapter/patients_list_adapter'
require_relative './DataStructures/ListAdapter/patients_list_db_adapter'
require_relative './DataStructures/ListAdapter/list_adapter'
require_relative './Views/patient_app'
require_relative './Controllers/patient_list_controller'
require 'fox16'

include Fox

begin
  db_config = { host: 'localhost', user: 'postgres', password: '1q2w34567', dbname: 'Hospital' }
  app = FXApp.new
  view = PatientApp.new(app, db_config)
  app.create
  app.run
rescue ArgumentError => e
  puts e.message
end