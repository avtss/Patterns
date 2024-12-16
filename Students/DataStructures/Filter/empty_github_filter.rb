require_relative './filter_decorator'

class EmptyGithubFilter < FilterDecorator
  def apply_filter(data)
    super(data).select { |student| student.github.nil? || student.github == '' }
  end
end
