#/usr/bin/ruby
# Brain*k
# Language: 💎
# Date: 2017-5-23
# Author: itzak

code = nil

if ARGV.size > 0
  code = File.read(ARGV[0])
else
  puts "Brain_K source file is missing!"
  exit
end

class Brain_K

  @@TOKENS = ['+', '-', '<', '>', '.', ',', '[', ']']
  
  def initialize(code)
    @data_segment = []
    @data_segment_point = 0
    @code_segment = code.chars.select{|c|@@TOKENS.include?(c)}
    @code_segment_point = 0
    @stack_segment = []
  end
  
  def ins
    if @data_segment[@data_segment_point]
      @data_segment[@data_segment_point] += 1
    else
      @data_segment[@data_segment_point] = 1
    end
  end

  def dec
    if @data_segment[@data_segment_point]
      @data_segment[@data_segment_point] -= 1
    else
      @data_segment[@data_segment_point] = 0
    end
  end

  def left_shift
    if @data_segment_point > 0
      @data_segment_point -= 1
    end
  end

  def right_shift
    @data_segment_point += 1
  end 

  def put_char
    print @data_segment[@data_segment_point]
  end

  def get_char
    @data_segment[@data_segment_point] = STDIN.gets.to_i
  end

  def left_parenthesis
    if @data_segment[@data_segment_point] != 0
      @stack_segment << @code_segment_point
    else
      point = nil
      (@code_segment_point + 1).upto(@code_segment.size - 1) do |i|
        if @code_segment[i] == @@TOKENS[7]
          point = i + 1
          break
        end
      end
      @code_segment_point = point
    end
  end

  def right_parenthesis
    if @data_segment[@data_segment_point] != 0
      @code_segment_point = @stack_segment.pop - 1
    else
      @stack_segment.pop
    end
  end

  def run
    while @code_segment[@code_segment_point] 
      case @code_segment[@code_segment_point]
        when @@TOKENS[0] then ins
        when @@TOKENS[1] then dec
        when @@TOKENS[2] then left_shift
        when @@TOKENS[3] then right_shift
        when @@TOKENS[4] then put_char
        when @@TOKENS[5] then get_char
        when @@TOKENS[6] then left_parenthesis
        when @@TOKENS[7] then right_parenthesis
      end
      @code_segment_point += 1
    end
    puts
  end

end

Brain_K.new(code).run
