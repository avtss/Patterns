require 'fox16'
include Fox

class StudentApp < FXMainWindow
  def initialize(app)
    super(app, "Список студентов", width: 800, height: 600)

    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL)

    tab1 = FXTabItem.new(tab_book, "Список студентов")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL)

    
    filter_frame = FXVerticalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)

    
    name_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(name_frame, "Фамилия и инициалы:")
    @name_field = FXTextField.new(name_frame, 25)

   
    git_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(git_frame, "Наличие гита:")
    @git_choice = FXComboBox.new(git_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @git_choice.appendItem("Да")
    @git_choice.appendItem("Нет")
    @git_choice.appendItem("Не важно")
    @git_choice.numVisible = 3
    FXLabel.new(git_frame, "Поиск по гиту:")
    @git_search_field = FXTextField.new(git_frame, 25)
    @git_search_field.enabled = true

    @git_choice.connect(SEL_COMMAND) do
      case @git_choice.currentItem
      when 0 
        @git_search_field.enabled = true
      else 
        @git_search_field.enabled = false
        @git_search_field.text = ""
      end
    end

    
    email_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(email_frame, "Наличие почты:")
    @email_choice = FXComboBox.new(email_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @email_choice.appendItem("Да")
    @email_choice.appendItem("Нет")
    @email_choice.appendItem("Не важно")
    @email_choice.numVisible = 3
    FXLabel.new(email_frame, "Поиск по почте:")
    @email_search_field = FXTextField.new(email_frame, 25)
    @email_search_field.enabled = true

    @email_choice.connect(SEL_COMMAND) do
      case @email_choice.currentItem
      when 0 
        @email_search_field.enabled = true
      else 
        @email_search_field.enabled = false
        @email_search_field.text = ""
      end
    end

   
    phone_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(phone_frame, "Наличие телефона:")
    @phone_choice = FXComboBox.new(phone_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @phone_choice.appendItem("Да")
    @phone_choice.appendItem("Нет")
    @phone_choice.appendItem("Не важно")
    @phone_choice.numVisible = 3
    FXLabel.new(phone_frame, "Поиск по телефону:")
    @phone_search_field = FXTextField.new(phone_frame, 25)
    @phone_search_field.enabled = true

    @phone_choice.connect(SEL_COMMAND) do
      case @phone_choice.currentItem
      when 0 
        @phone_search_field.enabled = true
      else 
        @phone_search_field.enabled = false
        @phone_search_field.text = ""
      end
    end

  
    telegram_frame = FXHorizontalFrame.new(filter_frame, LAYOUT_FILL_X)
    FXLabel.new(telegram_frame, "Наличие Telegram:")
    @telegram_choice = FXComboBox.new(telegram_frame, 3, nil, 0, COMBOBOX_STATIC | COMBOBOX_NO_REPLACE | LAYOUT_FILL_X)
    @telegram_choice.appendItem("Да")
    @telegram_choice.appendItem("Нет")
    @telegram_choice.appendItem("Не важно")
    @telegram_choice.numVisible = 3
    FXLabel.new(telegram_frame, "Поиск по Telegram:")
    @telegram_search_field = FXTextField.new(telegram_frame, 25)
    @telegram_search_field.enabled = true

    @telegram_choice.connect(SEL_COMMAND) do
      case @telegram_choice.currentItem
      when 0 
        @telegram_search_field.enabled = true
      else 
        @telegram_search_field.enabled = false
        @telegram_search_field.text = ""
      end
    end

    table_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL)
    @table = FXTable.new(table_frame, nil, 0, TABLE_COL_SIZABLE | LAYOUT_FILL)

    @table.setTableSize(0, 4)
    @table.setColumnText(0, "ID")
    @table.setColumnText(1, "ФИО")
    @table.setColumnText(2, "Git")
    @table.setColumnText(3, "Контакт")

    control_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
    add_button = FXButton.new(control_frame, "Добавить")
    edit_button = FXButton.new(control_frame, "Изменить")
    delete_button = FXButton.new(control_frame, "Удалить")
    update_button = FXButton.new(control_frame, "Обновить")

    tab2 = FXTabItem.new(tab_book, "2")
    FXVerticalFrame.new(tab_book, LAYOUT_FILL).tap do |frame|
      FXLabel.new(frame, "2", nil, LAYOUT_CENTER_X)
    end

    tab3 = FXTabItem.new(tab_book, "3")
    FXVerticalFrame.new(tab_book, LAYOUT_FILL).tap do |frame|
      FXLabel.new(frame, "3", nil, LAYOUT_CENTER_X)
    end

    quit_button = FXButton.new(self, "Закрыть окно", nil, nil, 0, FRAME_RAISED | LAYOUT_FILL_X)
    quit_button.connect(SEL_COMMAND) { getApp().exit }
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end
end
