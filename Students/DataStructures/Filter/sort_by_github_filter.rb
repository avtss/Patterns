require_relative './filter_decorator'

class SortByGithubFilter < FilterDecorator
  def apply_filter(data)
    super(data).sort_by { |student| student.github || '' }
  end
end
