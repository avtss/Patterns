require_relative './filter_decorator'
class FindByGitFilter < FilterDecorator
  def initialize(filter, github)
    super(filter)
    @github = github
  end
  def apply_filter(data)
    super(data).select { |student| student.github == @github }
  end
end