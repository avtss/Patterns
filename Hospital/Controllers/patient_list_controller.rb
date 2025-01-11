class PatientListController
  def initialize(view, db_config)
    @view = view
    @patient_list = ListAdapter.new(PatientsListDBAdapter.new(db_config))
    @data_list_patient_short = DataListPatientShort.new([])
    @data_list_patient_short.add_observer(@view)
  end

  def refresh_data
    @data_list_patient_short.data = @patient_list.get_k_n_patient_short_list(@view.current_page, @view.items_per_page).data
    @data_list_patient_short.selected = @patient_list.get_k_n_patient_short_list(@view.current_page, @view.items_per_page).selected
    @data_list_patient_short.count = @patient_list.get_patient_short_count   
    @data_list_patient_short.notify
  end
  
    def update_pagination(current_page, total_pages)
      @view.page_label.text = "Страница: #{current_page}/#{total_pages}"
    end
  
    def change_page(page)
      total_items = @patient_list.get_patient_short_count
      total_pages = (total_items.to_f / @view.items_per_page).ceil
  
      new_page = @view.current_page + page
      return if new_page < 1 || new_page > total_pages
  
      @view.current_page = new_page
      refresh_data
    end
end
