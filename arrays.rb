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
    file = File.open(path, "r")
    ar = file.read.split.map(&:to_i)
    file.close
    ar
  rescue => e
    puts "Ошибка при чтении файла: #{e.message}"
    []
  end
end


