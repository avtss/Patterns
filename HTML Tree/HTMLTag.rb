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

  def count_children
		children.size
	end

	def has_children?
		!children.empty?
	end

	def to_s(indent = 0)
		indentation = '  ' * indent
		opening_tag = "<#{tag_name}#{attributes_string}>"
		closing_tag = "</#{tag_name}>"

		if content.nil? && children.empty?
			"#{indentation}#{opening_tag}/>\n"
		else
			result = "#{indentation}#{opening_tag}\n"
			result += "#{indentation}  #{content}\n" if content
			children.each { |child| result += child.to_s(indent + 1) }
			result += "#{indentation}#{closing_tag}\n"
			result
		end
	end

	def attributes_string
		attributes.map { |key, value| " #{key}='#{value}'" }.join
	end

	def children_string
		children.map(&:to_s).join
	end
end