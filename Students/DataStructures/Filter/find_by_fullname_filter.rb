require_relative './filter_decorator'

class FindByFullnameFilter < FilterDecorator
  def initialize(filter, fullname)
    super(filter)
    @fullname = fullname
  end

  def apply_filter(data)
    super(data).select { |student| student.fullname == @fullname }
  end
end
