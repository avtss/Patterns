require 'fox16'
require_relative '../DataStructures/ListAdapter/list_adapter'
require_relative '../DataStructures/ListAdapter/students_list_db_adapter'
require_relative '../Database/DB_Connection'
require_relative '../DataStructures/Filter/filter'
require_relative '../DataStructures/Filter/sort_by_fullname_filter'

include Fox

class StudentApp < FXMainWindow
  def initialize(app, db_config)
    super(app, "Список студентов", width: 1200, height: 700)
    #db connect
    db_connection = DB_Connection.instance(db_config)
    db_adapter = Students_list_db_adapter.new(db_connection)
    @list_adapter = List_adapter.new(db_adapter)

    @current_page = 1
    @items_per_page = 20

    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL)

    tab1 = FXTabItem.new(tab_book, "Список студентов")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL)

    filter_frame = FXVerticalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)

    #git
    git_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(git_filter_frame, "Наличие гита:")
    @git_choice = FXComboBox.new(git_filter_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @git_choice.appendItem("Да")
    @git_choice.appendItem("Нет")
    @git_choice.appendItem("Не важно")
    @git_choice.numVisible = 3
    FXLabel.new(git_filter_frame, "Поиск по гиту:")
    @git_search_field = FXTextField.new(git_filter_frame, 25)
    @git_search_field.enabled = true

    @git_choice.connect(SEL_COMMAND) do
      @git_search_field.enabled = @git_choice.currentItem == 0
      @git_search_field.text = "" unless @git_search_field.enabled
    end

    #email
    email_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(email_filter_frame, "Наличие почты:")
    @email_choice = FXComboBox.new(email_filter_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @email_choice.appendItem("Да")
    @email_choice.appendItem("Нет")
    @email_choice.appendItem("Не важно")
    @email_choice.numVisible = 3
    FXLabel.new(email_filter_frame, "Поиск по почте:")
    @email_search_field = FXTextField.new(email_filter_frame, 25)
    @email_search_field.enabled = true

    @email_choice.connect(SEL_COMMAND) do
      @email_search_field.enabled = @email_choice.currentItem == 0
      @email_search_field.text = "" unless @email_search_field.enabled
    end

    #phone
    phone_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(phone_filter_frame, "Наличие телефона:")
    @phone_choice = FXComboBox.new(phone_filter_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @phone_choice.appendItem("Да")
    @phone_choice.appendItem("Нет")
    @phone_choice.appendItem("Не важно")
    @phone_choice.numVisible = 3
    FXLabel.new(phone_filter_frame, "Поиск по телефону:")
    @phone_search_field = FXTextField.new(phone_filter_frame, 25)
    @phone_search_field.enabled = true

    @phone_choice.connect(SEL_COMMAND) do
      @phone_search_field.enabled = @phone_choice.currentItem == 0
      @phone_search_field.text = "" unless @phone_search_field.enabled
    end

    #tg
    telegram_filter_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(telegram_filter_frame, "Наличие Telegram:")
    @telegram_choice = FXComboBox.new(telegram_filter_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @telegram_choice.appendItem("Да")
    @telegram_choice.appendItem("Нет")
    @telegram_choice.appendItem("Не важно")
    @telegram_choice.numVisible = 3
    FXLabel.new(telegram_filter_frame, "Поиск по Telegram:")
    @telegram_search_field = FXTextField.new(telegram_filter_frame, 25)
    @telegram_search_field.enabled = true

    @telegram_choice.connect(SEL_COMMAND) do
      @telegram_search_field.enabled = @telegram_choice.currentItem == 0
      @telegram_search_field.text = "" unless @telegram_search_field.enabled
    end

    #table
    table_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL)
    @table = FXTable.new(table_frame, nil, 0, TABLE_COL_SIZABLE | LAYOUT_FILL | TABLE_READONLY | TABLE_NO_COLSELECT)
    setup_table

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
    #tab2
    tab2 = FXTabItem.new(tab_book, "2")
    FXVerticalFrame.new(tab_book, LAYOUT_FILL).tap do |frame|
      FXLabel.new(frame, "2", nil, LAYOUT_CENTER_X)
    end
    #tab3
    tab3 = FXTabItem.new(tab_book, "3")
    FXVerticalFrame.new(tab_book, LAYOUT_FILL).tap do |frame|
      FXLabel.new(frame, "3", nil, LAYOUT_CENTER_X)
    end
    #closeapp
    quit_button = FXButton.new(self, "Закрыть окно", nil, nil, 0, FRAME_RAISED | LAYOUT_FILL_X)
    quit_button.connect(SEL_COMMAND) { getApp().exit }

    load_data
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  private

  def setup_table
    @table.setTableSize(0, 4)

    @table.setColumnWidth(0, 50)
    @table.setColumnWidth(1, 200)
    @table.setColumnWidth(2, 600)
    @table.setColumnWidth(3, 200)
    
  end

  def load_data
  total_items = @list_adapter.get_student_short_count(@filter)
  total_pages = (total_items.to_f / @items_per_page).ceil

  update_pagination_label(@current_page, total_pages)

  data_list = @list_adapter.get_k_n_student_short_list(@current_page, @items_per_page, @filter)
  data_table = data_list.get_data

  @table.setTableSize(data_table.row_count - 1, data_table.col_count)

  column_names = data_table.get_element(0, 0..data_table.col_count - 1)
  column_names.each_with_index do |name, index|
    @table.setColumnText(index, name)
  end

  (1...data_table.row_count).each do |row_index|
    (0...data_table.col_count).each do |col_index|
      @table.setItemText(row_index - 1, col_index, data_table.get_element(row_index, col_index).to_s)
    end
  end
end

  def update_pagination_label(current_page, total_pages)
    @page_label.text = "Страница: #{current_page}/#{total_pages}"
  end

  def change_page(page)
    total_items = @list_adapter.get_student_short_count
    total_pages = (total_items.to_f / @items_per_page).ceil

    new_page = @current_page + page
    return if new_page < 1 || new_page > total_pages

    @current_page = new_page
    load_data
  end
end
