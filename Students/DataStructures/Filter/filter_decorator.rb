require_relative './filter'

class FilterDecorator < Filter
  def initialize(filter)
    @filter = filter
  end

  def apply_filter(filterdata)
    @filter.apply_filter(filterdata)
  end
end