require_relative './filter_decorator'
class FindByPhoneFilter < FilterDecorator
  def initialize(filter, phone)
    super(filter)
    @phone = phone
  end
  def apply_filter(data)
    super(data).select { |student| student.phone == @phone }
  end
end