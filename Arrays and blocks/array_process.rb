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
end
