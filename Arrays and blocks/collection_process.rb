# Поиск элементов, расположенных перед первым минимальным
def before_first_min
	puts "Введите элементы массива через пробел"
	arr = gets.chomp.split.map(&:to_i)
	result = arr.take_while { |x| x!= arr.min }
end

# Проверка, является ли элемент локальным максимумом
def local_max?
	puts "Введите элементы массива через пробел"
	arr = gets.chomp.split.map(&:to_i)
	puts "Введите индекс, по которому нужно проверить элемент на локальный максимум"
	ind = gets.chomp.to_i
	if ind <= 0 || ind >= arr.size - 1
		puts "Введен неверный индекс"
		return
	end
	result = arr[ind] > arr[ind-1] && arr[ind] > arr[ind+1]
end

# Поиск элементов меньше среднего арифметического
def less_than_average
	puts "Введите элементы массива через пробел"
	arr = gets.chomp.split.map(&:to_i)
	average = arr.sum.to_f / arr.size
	result = arr.select { |x| x<average}
end
