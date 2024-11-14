class HtmlTag
	attr_reader :tag_name, :attributes, :children
	attr_accessor :content 

	def initialize(tag_name:, attributes: {}, content: nil)
		@tag_name = tag_name
		@attributes = attributes
		@content = content
		@children = []
	end

	def add_child(tag)
		@children << tag if tag.is_a?(HtmlTag)
	end
end