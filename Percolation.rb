# public class Percolation {
#    public Percolation(int N)               // create N-by-N grid, with all sites blocked
#    public void open(int i, int j)          // open site (row i, column j) if it is not open already
#    public boolean isOpen(int i, int j)     // is site (row i, column j) open?
#    public boolean isFull(int i, int j)     // is site (row i, column j) full?
#    public boolean percolates()             // does the system percolate?

#    public static void main(String[] args)  // test client (optional)
# }

#we need to create two imaginary roots at TOP ROW and at BOTTOM ROW

require_relative "WeightedQuickUnion"

class Percolation

  attr_reader :percolation_values, :quick_union_values

  def initialize(n)
    @size = n
    @percolation_values = Array.new(n*n) { "B"}   
    # @percolation_values = Array.new(n*n) { |i| (i+1).to_s }
    @quick_union_values = WeightedQuickUnion.new(n*n + 2) # 1(Top) + n*n + 1(bottom)
    # p @quick_union_values
  end

  def open(i, j) #row, column
    row = (i - 1)
    column = (j - 1)
    current_index = row * @size + column

    if self.percolation_values[current_index] == "F"
      return
    end

    self.percolation_values[current_index] = "O"

    if i == 1 #Open top and make full
      union_virtual_top(current_index)
    elsif i == @size #connect to bottom virtual node
      union_virtual_bottom(current_index)
    end

    indicies = Hash.new(0)

    # left_index = i * j - 2
    indicies[:left_index] = {row: i, column: (j - 1), valid: j == 1 ? false : true}#[row, column - 1, j == 1 ? false : true, left_index]

    # right_index = i * j
    indicies[:right_index] = {row: i, column: (j + 1), valid: j == @size ? false : true}#[row, column + 1, j == @size ? false : true, right_index]

    # top_index = (i - 1) * j - 1
    indicies[:top_index] = {row: (i - 1), column: j, valid: i == 1 ? false : true}#[(row - 1), column, i == 1 ? false : true, top_index]

    # bottom_index = (i + 1) * j - 1
    indicies[:bottom_index] = {row: (i + 1), column: j, valid: i == @size ? false : true}#[(row + 1), column, i == @size ? false : true, bottom_index];


    puts "Row: #{i}, Column: #{j}, Current_Value: #{self.percolation_values[current_index]}"
    puts "Indicies: #{indicies}"
    puts "#{self.quick_union_values.values}"

    #connect all open and full 
    #check if I am connected to parent
    #update all the other open branches
    indicies.each do |index, value|
      section_index = (value[:row] - 1) * @size + (value[:column] - 1)
      if (is_full?(value[:row], value[:column]) || is_open?(value[:row], value[:column]))
        if value[:valid] == true
          puts "Connecting"
          puts "#{index}: #{self.percolation_values[section_index]}"    
          puts "#{self.quick_union_values.values}"
          self.quick_union_values.union(current_index, section_index)
        end
      end
    end

    if self.quick_union_values.connected(0, current_index)
      self.percolation_values[current_index] = "F"
      self.pretty_print
      puts "Row: #{i}, Column: #{j}, Current_Value: #{self.percolation_values[current_index]}"
      indicies.each do |index, value|
      section_index = (value[:row] - 1) * @size + (value[:column] - 1)
        puts "Checking"
        puts "#{index}: Value: #{value} #{self.percolation_values[section_index]}"
        if (is_open?(value[:row], value[:column]) && value[:valid] == true)
          puts "Updating"
          puts "#{index}: #{self.percolation_values[section_index]}"
          puts "#{self.quick_union_values.values}"
          self.open(value[:row], value[:column])
        end
      end

    end
  end

  def is_open?(i, j)
    row = (i - 1)
    column = (j - 1)
    current_index = row * @size + column
    self.percolation_values[current_index] == "O" ? true : false
  end

  def is_full?(i, j)
    row = (i - 1)
    column = (j - 1)
    current_index = row * @size + column
    self.percolation_values[current_index] == "F" ? true : false
  end

  def percolates?
    self.quick_union_values.connected(0, @size*@size+1)
  end


  def pretty_print
   @percolation_values.length.times do |i|
    print @percolation_values[i] + " "
    puts " " unless (i + 1) % @size != 0
   end
  end

  private

  def union_virtual_top(index)
    self.quick_union_values.union(0, index)
  end

  def union_virtual_bottom(index)
    self.quick_union_values.union(@size**2 + 1, index)
  end

end

size = 10
count = 0

a = Percolation.new(size)

puts "#{a.quick_union_values.values}"

while !a.percolates?
  rand1 = rand 1..size
  rand2 = rand 1..size
  a.open(rand1, rand2)
  count++
  a.pretty_print
  puts "--------"

end

percentage = count / (size**2)

puts "Percentage: #{percentage}"



# a.pretty_print
puts a.percolates?

# p a.quick_union_values

#New Test Here

# a.open(1,1)
# p a.quick_union_values

# a.open(3,3)
# p a.quick_union_values

# a.open(3,4)
# p a.quick_union_values

# a.open(2,4)
# p a.quick_union_values

# a.open(2,2)
# p a.quick_union_values

# a.open(2,1)
# p a.quick_union_values

# a.open(3,2)
# p a.quick_union_values

# a.open(4,2)
# p a.quick_union_values

# a.pretty_print
# puts a.percolates?
# print a.percolation_values
