# Поиск элементов, расположенных перед первым минимальным
def before_first_min
	puts "Введите элементы массива через пробел"
	arr = gets.chomp.split.map(&:to_i)
	result = arr.take_while { |x| x!= arr.min }
	puts "Элементы, находящиеся перед первым минимальным: #{result}"
end
