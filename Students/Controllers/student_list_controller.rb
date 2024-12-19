class StudentListController
  def initialize(view, db_config)
    @view = view
    @student_list = List_adapter.new(Students_list_db_adapter.new(DB_Connection.instance(db_config)))
    @filter = Filter.new
  end

  def setup_table
    @view.table.setTableSize(0, 4)
    @view.table.setColumnWidth(0, 50)
    @view.table.setColumnWidth(1, 200)
    @view.table.setColumnWidth(2, 600)
    @view.table.setColumnWidth(3, 200)
  end

  def load_data
    total_items = @student_list.get_student_short_count(@filter)
    total_pages = (total_items.to_f / @view.items_per_page).ceil
  
    update_pagination_label(@view.current_page, total_pages)
  
    data_list = @student_list.get_k_n_student_short_list(@view.current_page, @view.items_per_page, @filter)
    data_table = data_list.get_data
  
    @view.table.setTableSize(data_table.row_count - 1, data_table.col_count)
  
    column_names = data_table.get_element(0, 0..data_table.col_count - 1)
    column_names.each_with_index do |name, index|
      @view.table.setColumnText(index, name)
    end
  
    (1...data_table.row_count).each do |row_index|
      (0...data_table.col_count).each do |col_index|
        @view.table.setItemText(row_index - 1, col_index, data_table.get_element(row_index, col_index).to_s)
      end
    end
  end
  
    def update_pagination_label(current_page, total_pages)
      @view.page_label.text = "Страница: #{current_page}/#{total_pages}"
    end
  
    def change_page(page)
      total_items = @student_list.get_student_short_count
      total_pages = (total_items.to_f / @view.items_per_page).ceil
  
      new_page = @view.current_page + page
      return if new_page < 1 || new_page > total_pages
  
      @view.current_page = new_page
      load_data
    end
end
