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
def gcd(a, b)
  a_copy = a
  b_copy = b
  while b_copy != 0
    a_copy, b_copy = b_copy, a_copy % b_copy
  end
  a_copy
end

def coprimes(number1,number2)
  divider=gcd(number1,number2)
  if divider == 1 then return true end
  return false
end
def prime_dig_sum(num)
  c=0
  copy=num
  while copy>1
    if is_prime copy%10
      c+=copy%10
    end
    copy/=10

  end
  return c
end
def nondiv_noncoprime_coprimesum(num)
  count = 0
  (2..num).each do |n|
    
    next unless num % n != 0 && !coprimes(n, num) && coprimes(n, prime_dig_sum(num))
    count += 1
  end
  count
end


