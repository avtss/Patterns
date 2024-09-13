def is_prime(num)
  return false if num < 2

  c = 0
  (1..num).each do |i|
    if num % i == 0
      c += 1
    end
  end

  c == 2
end

def sum_of_nonprime_dividers(num)
  sum = 0
  (1..num).each do |i|
    if num % i == 0 && !is_prime(i)
      sum += i
    end
  end
  sum
end
def less_num_count(num)
  c=0
  copy=num
  while copy>1
    if copy%10<3
      c+=1
    end
    copy/=10
  end
  return c
end
