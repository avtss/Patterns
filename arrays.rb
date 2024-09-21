def find_min(ar)
  min_value = ar[0]
  for i in 1...ar.length
    if ar[i] < min_value
      min_value = ar[i]
    end
  end
  min_value
end
def find_max(ar)
  max_value = ar[0]
  for i in 1...ar.length
    if ar[i] > max_value
      max_value = ar[i]
    end
  end
  max_value
end
def first_positive_found(ar)
  for i in 0...ar.length
    return i if ar[i] > 0
  end
  -1 
end
def read(path)
  begin
    file = File.open(path, "r") do |file|
      ar = file.read
      ar.split.map(&:to_i)
    end
  rescue => e
    puts "Ошибка при чтении файла: #{e.message}"
    []
  end
end


if ARGV.size == 2
  method=ARGV[0].to_i
  file=ARGV[1]
  array=read(file)
  if method==1
    puts "Минимальное значение в массиве: #{find_min(array)}"
  end
  if method==2
    puts "Максимальное значение в массиве: #{find_max(array)}"
  end
  if method==3
    ind=first_positive_found(array) + 1
    puts "Первое положительное значение находится под индексом #{ind}"
  end
end
if ARGV.size != 2
  puts "Введите два аргумента"
end


