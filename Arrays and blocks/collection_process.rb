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

# Поиск элементов, встречающихся более 3 раз
def more_than_three_times
	puts "Введите элементы массива через пробел"
	arr = gets.chomp.split.map(&:to_i)
	result = arr.select {|x| arr.count(x) > 3}.uniq
end

loop do
	puts "Выберите, что нужно выполнить:"
	puts "1. Найти элементы, расположенные перед первым минимальным"
	puts "2. Проверить, является ли элемент по указанному индексу локальным максимумом"
	puts "3. Найти элементы меньше среднего арифметического"
	puts "4. Найти элементы, встречающиеся более трех раз"
	puts "0. Выход"
	choice = gets.chomp.to_i

	case choice
	when 1
		puts before_first_min

	when 2
		if local_max?
			puts "Элемент под этим индексом является локальным максимумом"
		else
			puts "Элемент под этим индексом является локальным максимумом"
		end
	when 3
		puts less_than_average
	when 4
		puts more_than_three_times
	when 0
		puts "Завершение программы"
		break
	else 
		puts "Неправильное значение"
	end
end