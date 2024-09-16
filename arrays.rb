def find_min(arr)
  min_value = arr[0]
  for i in 1...arr.length
    if arr[i] < min_value
      min_value = arr[i]
    end
  end
  min_value
end
def find_max
  max_value = arr[0]
  for i in 1...arr.length
    if arr[i] > max_value
      max_value = arr[i]
    end
  end
  max_value
end
def first_found(arr)
  for i in 0...arr.length
    return i if arr[i] > 0
  end
  -1 
end

