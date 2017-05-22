#/usr/bin/ruby
# Brain*k
# Language: 💎
# Date: 2017-5-23
# Author: itzak

code = nil

if ARGV.size > 0
  code = File.read(ARGV[0])
else
  puts "BF source file is missing!"
  exit
end

class BF

  attr_reader :ds
  
  @@TOKENS = ['+', '-', '<', '>', '.', ',', '[', ']']
  
  def initialize(code)
    @ds = []
    @dp = 0
    @cs = code.chars.select{|c|@@TOKENS.include?(c)}
    @cp = 0
    @ss = []
  end
  
  def add
    if @ds[@dp]
      @ds[@dp] += 1
    else
      @ds[@dp] = 1
    end
  end

  def sub
    if @ds[@dp]
      @ds[@dp] -= 1
    else
      @ds[@dp] = 0
    end
  end

  def right
    @dp += 1
  end 

  def left
    if @dp > 0
      @dp -= 1
    end
  end

  def putchar
    print @ds[@dp]
  end

  def getchar
    @ds[@dp] = STDIN.gets.to_i
  end

  def start
    if @ds[@dp] != 0
      @ss << @cp
    else
      point = nil
      (@cp + 1).upto(@cs.size - 1) do |i|
        if @cs[i] == @@TOKENS[7]
          point = i + 1
          break
        end
      end
      @cp = point
    end
  end

  def stop
    if @ds[@dp] != 0
      @cp = @ss.pop - 1
    else
      @ss.pop
    end
  end

  def run
    while @cs[@cp] 
      case @cs[@cp]
        when @@TOKENS[0] then add
        when @@TOKENS[1] then sub
        when @@TOKENS[2] then left
        when @@TOKENS[3] then right
        when @@TOKENS[4] then putchar
        when @@TOKENS[5] then getchar
        when @@TOKENS[6] then start
        when @@TOKENS[7] then stop
      end
      @cp += 1
    end
    puts
  end

end

BF.new(code).run
