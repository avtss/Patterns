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
root = Node.new(1)
tree = Tree.new(root)

tree.add_child(Node.new(2), root)
tree.add_child(Node.new(3), root)
tree.bfs do |node|
	puts node.to_s
end