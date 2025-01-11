require 'fox16'
require_relative '../DataStructures/ListAdapter/list_adapter'
require_relative '../DataStructures/ListAdapter/patients_list_db_adapter'
require_relative '../Database/DB_Connection'

include Fox

class PatientApp < FXMainWindow
  attr_reader :items_per_page, :page_label, :table
  attr_accessor :current_page
  def initialize(app, db_config)
    super(app, "Список пациентов", width: 1200, height: 700)
    @controller = PatientListController.new(self, db_config)

    @current_page = 1
    @items_per_page = 20

    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL)

    tab1 = FXTabItem.new(tab_book, "Список пациентов")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL)

    #table
    table_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL)
    @table = FXTable.new(table_frame, nil, 0, TABLE_COL_SIZABLE | LAYOUT_FILL | TABLE_READONLY | TABLE_NO_COLSELECT)


    #pages
    pagination_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    prev_button = FXButton.new(pagination_frame, "Предыдущая")
    @page_label = FXLabel.new(pagination_frame, "Страница: 1/1", nil, JUSTIFY_CENTER_X)
    next_button = FXButton.new(pagination_frame, "Следующая")
    prev_button.connect(SEL_COMMAND) { change_page(-1) }
    next_button.connect(SEL_COMMAND) { change_page(1) }
    #control buttons
    control_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    add_button = FXButton.new(control_frame, "Добавить")
    edit_button = FXButton.new(control_frame, "Изменить")
    delete_button = FXButton.new(control_frame, "Удалить")
    update_button = FXButton.new(control_frame, "Обновить")
    edit_button.enabled = false
    delete_button.enabled = false
    update_button.connect(SEL_COMMAND) do
      @controller.refresh_data
    end

    @table.connect(SEL_SELECTED) do
      selected_rows = (@table.selStartRow..@table.selEndRow).to_a
      selected_count = selected_rows.count { |row| @table.rowSelected?(row) }
    
      if selected_count == 0
        edit_button.enabled = false
        delete_button.enabled = false
      elsif selected_count == 1
        edit_button.enabled = true
        delete_button.enabled = true
      else
        edit_button.enabled = false
        delete_button.enabled = true
      end
    end
    
    @table.connect(SEL_DESELECTED) do
      edit_button.enabled = false
      delete_button.enabled = false
    end
    
    #closeapp
    quit_button = FXButton.new(self, "Закрыть окно", nil, nil, 0, FRAME_RAISED | LAYOUT_FILL_X)
    quit_button.connect(SEL_COMMAND) { getApp().exit }

    @controller.refresh_data
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def set_table_params(column_names, whole_entities_count)
    @table.setTableSize(0, column_names.size)
    column_names.each_with_index do |name, index|
      @table.setColumnText(index, name)
    end
    total_pages = (whole_entities_count.to_f / @items_per_page).ceil
    update_pagination(@current_page, total_pages)
  end

  def set_table_data(data_table)
    @table.setTableSize(data_table.row_count, data_table.col_count)
    (0...data_table.row_count).each do |row_index|
      (0...data_table.col_count).each do |col_index|
        @table.setItemText(row_index, col_index, data_table.get_element(row_index, col_index).to_s)
      end
    end
  end

  private

  def update_pagination(current_page, total_pages)
    @controller.update_pagination(current_page, total_pages)
  end

  def change_page(page)
    @controller.change_page(page)
  end
end
