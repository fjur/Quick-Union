class QuickUnion

  attr_reader :values

  def initialize(n)
    @values = setupValues(n)
  end

  #union
  #connects p to q, p root becomes child of q root
  def union(p, q)
    @values[root(p)] = root(q)
  end

  def connected(p, q)
    @values[root(p)] == @values[root(q)] ? true : false
  end

  private

  def root(p) #gets index, finds out the root
    #we get 4, and right now it is checking the value at 4
    #want to get index 4, check if its value is the same
    #if yes then return
    #if not, go to the value that 4 has, and check if its index is the same
    index = p
    value = @values[index]

    while index != value
      index = value
      value = @values[index]
    end
    index

  end

  def setupValues(n) 
    arr = Array.new(0);
    n.times do |x| 
      arr.push(x)
    end
    arr
  end

end

a = QuickUnion.new(10)

a.union(4,3)
a.union(3,8)
a.union(6,5)
a.union(9,4)
a.union(2,1)
a.union(5,0)
a.union(7,2)
a.union(6,1)
a.union(7,3)

print a.values
# puts
# puts "Root of 0: #{a.root(0)}"
# puts "Root of 1: #{a.root(1)}"
# puts "Root of 2: #{a.root(2)}"
# puts "Root of 3: #{a.root(3)}"
# puts "Root of 4: #{a.root(4)}"
# puts "Root of 5: #{a.root(5)}"
# puts "Root of 6: #{a.root(6)}"
# puts "Root of 7: #{a.root(7)}"
# puts "Root of 8: #{a.root(8)}"
# puts "Root of 9: #{a.root(9)}"


