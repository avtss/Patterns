require_relative './filter_decorator'

class SortByContactFilter < FilterDecorator
  def apply_filter(data)
    super(data).sort_by { |student| student.contact || '' }
  end
end
