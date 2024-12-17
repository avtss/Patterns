require 'fox16'
include Fox

class StudentApp < FXMainWindow
  def initialize(app)
    super(app, "Список студентов", width: 800, height: 600)
    
    tab_book = FXTabBook.new(self, nil, 0, LAYOUT_FILL)

    tab1 = FXTabItem.new(tab_book, "Student_list_view")
    tab1_frame = FXVerticalFrame.new(tab_book, LAYOUT_FILL)

    FXLabel.new(tab1_frame, "Student_list_view", nil, LAYOUT_CENTER_X)

    table_frame = FXHorizontalFrame.new(tab1_frame, LAYOUT_FILL)
    @table = FXTable.new(table_frame, nil, 0, TABLE_COL_SIZABLE | LAYOUT_FILL)

    @table.setTableSize(0, 4) 
    @table.setColumnText(0, "№")
    @table.setColumnText(1, "ФИО")
    @table.setColumnText(2, "Git")
    @table.setColumnText(3, "Контакт")


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
