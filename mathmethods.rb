def is_prime(num)
  return false if num < 2  # Простые числа начинаются с 2

  c = 0
  (1..num).each do |i|
    if num % i == 0
      c += 1
    end
  end

  c == 2
end
