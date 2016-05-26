#QuickFind has the values link directly to the root
#QuickUnion has valeus link to their parent
#WEighted Quick Union has values that link to larger subtrees root

class QuickFind

  attr_reader :values

  def initialize(n)
    @values = setupValues(n)
  end

  #union
  #create a union between them
  def union(p, q) # p becomes q's values
    #changed values[q] to values[p]
    #change all values of that to it, look then?
    pValue = @values[p]
    qValue = @values[q]
    # puts
    # puts "union called"
    @values.length.times do |x|
      # puts "Comparing here: index: #{x}, values[x]: #{values[x]}, values[p]: #{values[p]}, values[q]: #{values[q]}"
      if values[x] == pValue
        # puts "changing values"
        values[x] = qValue
      end
    end
  end

  #connected
  #see if they are connected
  #return true if they are, false if they are not
  def connected(p, q)
     @values[p] == @values[q] ? true : false
  end

  private

  def setupValues(n) 
    arr = Array.new(0);
    n.times do |x| 
      arr.push(x)
    end
    arr
  end
end

a = QuickFind.new(10)
a.union(4,3)
a.union(3,8)
a.union(6,5)
a.union(9,4)
a.union(2,1)
a.union(5,0)
a.union(7,2)
a.union(6,1)

print a.values
puts a.connected(4,3)
# puts a.values
# b = QuickFind.new('troll')
# puts b.values
