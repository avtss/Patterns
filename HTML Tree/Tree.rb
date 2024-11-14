require "./HTMLTag.rb"

class Tree
	include Enumerable

	attr_accessor :root

	def initialize(root = nil)
		@root = root
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
		bfs_each(&block)
	end

	def to_html
		@root.to_s
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
#html = HtmlTag.new(tag_name: "html")
#body = HtmlTag.new(tag_name: "body")
#div = HtmlTag.new(tag_name: "div", attributes: { class: "container" })
#p = HtmlTag.new(tag_name: "p", content: "Hello, World!")

#html_tree = Tree.new(html)
#html_tree.add_child(body, html)
#html_tree.add_child(div, body)
#html_tree.add_child(p, div)

#puts "HTML Tree:"
#puts html_tree.to_html