class Tree
	include Enumerable

	attr_accessor :root

	def initialize(root = nil)
		@root = root
	end

	def each(&block)
	    dfs(&block)
	end

	def add_child(node, parent = nil)
	    if parent.nil?
	    	@root = node
	    else
	      	parent.add_child(node)
	    end
	end
end