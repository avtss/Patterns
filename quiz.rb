user_name = ARGV[0]
puts "Привет, #{user_name}, какой у тебя любимый язык программирования?"
favorite_lang=STDIN.gets.chomp
case favorite_lang
when "Ruby"
  puts "Подлиза"
when "Java"
  puts "молодец"
when "C++"
  puts "))"
else
  puts "Скоро будет Ruby"
end

puts "#{user_name}, введите команду языка Ruby"
rubycommand=STDIN.gets.chomp
eval(rubycommand)

puts "#{user_name}, введите команду ОС"
oscommand=STDIN.gets.chomp
system oscommand