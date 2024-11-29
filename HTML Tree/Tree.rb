require "./HTMLTag.rb"

class Tree
	include Enumerable

	attr_accessor :root

	def initialize(html_document = nil)
		@root = parse_html(html_document) if html_document
	end

	def add_child(node, parent = nil)
	    if parent.nil?
	    	@root = node
	    else
	      	parent.add_child(node)
	    end
	end

	def bfs
		return if @root.nil?

	    queue = [@root]
	    while queue.any?
	    	current_node = queue.shift
	      	yield(current_node)
	     	queue.concat(current_node.children)
	    end
	end

	def dfs
	    return if @root.nil?

	    stack = [@root]
	    while stack.any?
	    	current_node = stack.pop
	    	yield(current_node)
	    	current_node.children.reverse.each { |child| stack.push(child) } 
	    end
	end

	def each(&block)
		bfs(&block)
	end

	def to_html
		@root.to_s
	end

	private

	def divide_tags(html)
		html.scan(/<[^>]+>|[^<]+/)
	end

	def parse_html(html)
		tags = divide_tags(html) 
		build_tree(tags)      
	end

	def build_tree(divided_tags)
		stack = []
		root = nil
	
		divided_tags.each do |divided_tag|
		  if divided_tag.start_with?('<') && !divided_tag.start_with?('</')
			tag_name, attributes = parse_tag(divided_tag)
			tag = HtmlTag.new(tag_name: tag_name, attributes: attributes)
	
			if stack.any?
			  stack.last.add_child(tag)
			else
			  root = tag
			end
	
			unless divided_tag.end_with?('/>')
			  stack.push(tag)
			end
		  elsif divided_tag.start_with?('</')
			stack.pop
		  else
			next if divided_tag.strip.empty?
			stack.last.content = divided_tag.strip if stack.any?
		  end
		end
	
		root
	  end

	  def parse_tag(tag)
		tag.match(/<(\w+)(.*?)>/) do |match|
		  tag_name = match[1]
		  attributes = parse_attributes(match[2])
		  return [tag_name, attributes]
		end
	  end

	  def parse_attributes(attributes_string)
		attributes = {}
		attributes_string.scan(/(\w+)=['"](.*?)['"]/) do |key, value|
		  attributes[key] = value
		end
		attributes
	  end
end

class Node
	attr_accessor :value, :children
  
	def initialize(value)
	  @value = value
	  @children = []
	end
  
	def add_child(node)
	  @children << node
	end

	def to_s
		@value
	end
end