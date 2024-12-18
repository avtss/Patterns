require_relative './filter_decorator'
class FindByTelegramFilter < FilterDecorator
  def initialize(filter, telegram)
    super(filter)
    @telegram = telegram
  end
  def apply_filter(data)
    super(data).select { |student| student.telegram == @telegram }
  end
end