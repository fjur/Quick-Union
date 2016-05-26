class WeightedQuickUnion

  attr_reader :values
  attr_reader :weighted_values

  def initialize(n)
    init_values = setup_values(n)
    @values = init_values.first
    @weighted_values = init_values.last
  end

  #Weighted Union
  #connects p to q, p root becomes child of q root
  def union(p, q) #4, 3
    # puts "performing union of #{p}, #{q}"

    if connected(p,q)
      return
    end

    rootP = root(p)
    rootQ = root(q)
    weightP = @weighted_values[rootP]
    weightQ = @weighted_values[rootQ]
    #if equal weight, q becomes child of P root
    if weightP >= weightQ
      @values[rootQ] = rootP
      # puts "Weight p: #{@weighted_values[root(p)]}, weight q: #{@weighted_values[root(q)]} #2"
      @weighted_values[rootP] += @weighted_values[q]
      # puts "Weight p: #{@weighted_values[root(p)]}, weight q: #{@weighted_values[root(q)]}"
    else
      @values[rootP] = rootQ
      # puts "Weight p: #{@weighted_values[root(p)]}, weight q: #{@weighted_values[root(q)]} #1"
      @weighted_values[rootQ] += @weighted_values[p]
      # puts "Weight p: #{@weighted_values[root(p)]}, weight q: #{@weighted_values[root(q)]}"
      #update weight here
      #update weight here
    end

  end

  def connected(p, q)
    @values[root(p)] == @values[root(q)] ? true : false
  end

  def print_output
    print "Values: #{values}"
    puts 
    print "Weights: #{weighted_values}"
    puts
  end

  private

  def root(p) #gets index, finds out the root
    index = p
    value = @values[index]

    while index != value
      @values[index] = @values[@values[index]] #path Compression <- keeps compressing till it gets to root which will just point to itself, no out of bounds error
      index = value
      value = @values[index]
    end
    index

  end

  def setup_values(n) 
    values_arr = Array.new(0);
    weighted_arr = Array.new(0);
    n.times do |x| 
      values_arr.push(x)
      weighted_arr.push(1)
    end
    [values_arr, weighted_arr]
  end

end

a = WeightedQuickUnion.new(10)

# print a.weighted_values
# puts
# a.union(4,3)
# a.union(3,8)
# a.union(6,5) 
# a.union(9,4) 
# a.union(2,1)
# a.union(5,0)
# a.union(7,2)
# a.union(6,1)
# a.union(7,3)

# a.print_output


# [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]
# Values: [6, 2, 6, 4, 6, 6, 6, 6, 4, 4]
# Weights: [1, 1, 3, 1, 4, 1, 5, 1, 1, 1]

# print "Values: #{a.values}"
# puts 
# print "Weights: #{a.weighted_values}"
# puts a.weighted_values[8]



