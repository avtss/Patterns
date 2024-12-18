require_relative './filter_decorator'
class FindByEmailFilter < FilterDecorator
  def initialize(filter, email)
    super(filter)
    @email = email
  end
  def apply_filter(data)
    super(data).select { |student| student.email == @email }
  end
end