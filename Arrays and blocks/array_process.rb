class ArrayProcessor
	attr_reader :arr
  	#6,18,30,31,19,7
	def initialize(arr)
		@arr = arr
	end
	def detect
		arr.each do |element|
		  return element if yield(element)
		end
	end

	def map
		result = []
		arr.each do |element|
		  result << yield(element)
		end
		result
	end

	def select
		result = []
		arr.each do |element|
		  result << element if yield(element)
		end
		result
	end

	def sort()
		sorted_array = arr.dup	  
		for i in 0...sorted_array.length do
		  for j in 0...(sorted_array.length - i - 1) do
			if yield(sorted_array[j], sorted_array[j + 1]) > 0
			  temp = sorted_array[j]
			  sorted_array[j] = sorted_array[j + 1]
			  sorted_array[j + 1] = temp
			end
		  end
		end
		sorted_array
	end

	def max
		max_element = arr.first
		arr.each do |element|
		  comparison = block_given? ? yield(max_element, element) : (max_element <=> element)
		  max_element = element if comparison == -1
		end
		max_element
	end

	def drop_while
		result = []
		dropping = true
		arr.each do |element|
		  if dropping && yield(element)
			next
		  else
			dropping = false
			result << element
		  end
		end
		result
	  end
end
