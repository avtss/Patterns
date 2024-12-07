require_relative './array_process'

#detect
def test_detect_with_match
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.detect { |x| x > 20 } == 30
end

def test_detect_without_match
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  puts processor.detect {|x| x > 100}
  processor.detect { |x| x > 100 } == nil
end

#map
def test_map_double
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.map { |x| x * 2 } == [12, 36, 60, 62, 38, 14]
end

#select
def test_select_with_match
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.select { |x| x > 20 } == [30, 31]
end

def test_select_without_match
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.select { |x| x > 100 } == []
end

#sort
def test_sort_ascending
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.sort == [6, 7, 18, 19, 30, 31]
end

def test_sort_descending
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.sort { |a, b| b <=> a } == [31, 30, 19, 18, 7, 6]
end

#max
def test_max_default
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.max == 31
end

def test_max_with_block
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.max { |a, b| a.to_s <=> b.to_s } == 7
end

#drop_while
def test_drop_while_some
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.drop_while { |x| x < 20 } == [30, 31, 19, 7]
end

def test_drop_while_none
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.drop_while { |x| x > 100 } == [6, 18, 30, 31, 19, 7]
end

def test_drop_while_all
  processor = ArrayProcessor.new([6, 18, 30, 31, 19, 7])
  processor.drop_while { |x| x < 100 } == []
end

def run_tests
  puts "Test detect with match: #{test_detect_with_match}"
  puts "Test detect without match: #{test_detect_without_match}"
  puts "Test map double: #{test_map_double}"
  puts "Test select with match: #{test_select_with_match}"
  puts "Test select without match: #{test_select_without_match}"
  puts "Test sort ascending: #{test_sort_ascending}"
  puts "Test sort descending: #{test_sort_descending}"
  puts "Test max default: #{test_max_default}"
  puts "Test max with block: #{test_max_with_block}"
  puts "Test drop_while some: #{test_drop_while_some}"
  puts "Test drop_while none: #{test_drop_while_none}"
  puts "Test drop_while all: #{test_drop_while_all}"
end

run_tests
