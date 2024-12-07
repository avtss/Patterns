require_relative '../Entities/student.rb'

class Student_tree
    include Enumerable

    def initialize
		@root = nil
	end

    def insert(element)
		if @root.nil?
			@root = Node.new(element)
		else
			insert_node(@root, element)
		end
	end

    def each(&block)
		traversal(@root, &block)
	end

    private 

	def insert_node(node, element)
    	if element < node.element
      		if node.left.nil?
        		node.left = Node.new(element)
      		else
        		insert_node(node.left, element)
      		end
    	else
      		if node.right.nil?
        		node.right = Node.new(element)
      		else
        		insert_node(node.right, element)
      		end
    	end
	end

    #Обход дерева начиная с узла node
  	def traversal(node, &block)
    	return if node.nil?

    	traversal(node.left, &block)
    	yield(node.element)
    	traversal(node.right, &block)
    end
end

class Node
    attr_accessor :element, :left, :right

    def initialize(element)
        @element=element
        @left = nil
        @right = nil
    end
end