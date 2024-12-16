class Filter
  def initialize(filter = nil)
    @filter = filter
  end

  def apply_filter(data)
    @filter ? @filter.apply_filter(data) : data
  end
end
