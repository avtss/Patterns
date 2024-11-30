# Поиск элементов, расположенных перед первым минимальным
def before_first_min(arr)
	result = arr.take_while { |x| x!= arr.min }
end

#Сдвиг массива на 3 позиции
def rotate_three(arr)
	result=arr.rotate(3)
end

# Проверка, является ли элемент локальным максимумом
def local_max?(arr, ind)
	result = arr[ind] > arr[ind-1] && arr[ind] > arr[ind+1]
end

# Поиск элементов меньше среднего арифметического
def less_than_average(arr)
	average = arr.sum.to_f / arr.size
	result = arr.select { |x| x<average}
end

# Поиск элементов, встречающихся более 3 раз
def more_than_three_times(arr)
	result = arr.select {|x| arr.count(x) > 3}.uniq
end

loop do
	puts "Выберите, что нужно выполнить:"
	puts "1. Найти элементы, расположенные перед первым минимальным"
	puts "2. Проверить, является ли элемент по указанному индексу локальным максимумом"
	puts "3. Найти элементы меньше среднего арифметического"
	puts "4. Найти элементы, встречающиеся более трех раз"
	puts "5. Сдвинуть массив на 3 позиции"
	puts "0. Выход"
	choice = gets.chomp.to_i

	case choice
	when 1
		puts "Введите элементы массива через пробел"
		arr = gets.chomp.split.map(&:to_i)
		puts before_first_min(arr)
	when 2
		puts "Введите элементы массива через пробел"
		arr = gets.chomp.split.map(&:to_i)
		puts "Введите индекс, по которому нужно проверить элемент на локальный максимум"
		ind = gets.chomp.to_i
		if ind <= 0 || ind >= arr.size - 1
			raise ArgumentError, "Неправильный индекс"
		end
		if local_max?(arr, ind)
			puts "Элемент под этим индексом является локальным максимумом"
		else
			puts "Элемент под этим индексом не является локальным максимумом"
		end
	when 3
		puts "Введите элементы массива через пробел"
		arr = gets.chomp.split.map(&:to_i)
		puts "Элементы массива меньше среднего: #{less_than_average(arr)}" 
	when 4
		puts "Введите элементы массива через пробел"
		arr = gets.chomp.split.map(&:to_i)
		puts "Элементы, встречающиеся больше 3 раз: #{more_than_three_times(arr)}"
	when 5
		puts "Введите элементы массива через пробел"
		arr = gets.chomp.split.map(&:to_i)
		puts "Массив, сдвинутый на 3 позиции: #{rotate_three(arr)}"
	when 0
		puts "Завершение программы"
		break
	else 
		puts "Неправильное значение"
	end
end