require './student.rb'

class StudentTree
    include Enumerable

    def initialize
		@root = nil
	end

    def insert(student)
		unless student.is_a?(Student)
			raise ArgumentError, "Аргумент должен быть экземпляром класса Student"
		end

		if @root.nil?
			@root = Node.new(student)
		else
			insert_node(@root, student)
		end
	end

    def each(&block)
		traversal(@root, &block)
	end

    private 

	def insert_node(node, student)
    	if student < node.student
      		if node.left.nil?
        		node.left = Node.new(student)
      		else
        		insert_node(node.left, student)
      		end
    	else
      		if node.right.nil?
        		node.right = Node.new(student)
      		else
        		insert_node(node.right, student)
      		end
    	end
	end

    #Обход дерева начиная с узла node
  	def traversal(node, &block)
    	return if node.nil?

    	traversal(node.left, &block)
    	yield(node.student)
    	traversal(node.right, &block)
    end
end

class Node
    attr_accessor :student, :left, :right

    def initialize(student)
        @student = student
        @left = nil
        @right = nil
    end
end