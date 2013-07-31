require 'matrix'

class Salesman
  include Comparable
  attr_reader :dna, :fitness

  def initialize(dna=(0...N).to_a.shuffle)
    #dna is an array of integers, each represents ISLAND[n]
    @dna = dna 

    #calculate fitness
    path_lengths = [FIRST[@dna.first]] #from the starting point to first island

    #add all path lengths from island to island
    @dna.each_cons(2) { |island1,island2| path_lengths << MATRIX[island1,island2] }

    #also add path from last island back to starting point
    path_lengths << FIRST[@dna.last]

    #sum all the path lengths    
    @fitness = path_lengths.inject(&:+)
  end

  def pair_with(other)
    #forward the method call to the method defined in CROSSOVER
    send CROSSOVER, other
  end

  def <=>(other)
    @fitness <=> other.fitness
  end

  def mutate!
    #pick two random numbers between zero and N-1
    e = rand(0...N)
    f = rand(0...N)

    #pick the corresponding dna pieces
    g = @dna[e]
    h = @dna[f]

    #exchange them!
    @dna[e] = h
    @dna[f] = g
  end

  private

  #Crossover algorithms may be placed underneath...
  #Name the method like the crossover algorithm!

  def simple_swap(other)
    #actually the easiest-to-implement algorithm I could think of,
    #it splits the two dnas in two halves (a1,a2 and b1,b2), then tries
    #to recombine these like so; a1,b2 and b1,a2

    ##################################################

    #pools (all islands, once for every child)
    #use own dna because it's a valid pool
    pool1 = @dna.dup
    pool2 = other.dna.dup

    #add the first half of the parents' dnas to the children's dnas
    child1 = pool1.slice!(0...N/2)
    child2 = pool2.slice!(0...N/2)

    #fill the second half of each child dna with as much as possible of the other parent's dna
    child1.concat other.dna[N/2..-1].collect { |parent_dna| pool1.delete parent_dna }
    child2.concat @dna[N/2..-1].collect { |parent_dna| pool2.delete parent_dna }

    #fill the nils with random islands from the pools
    child1.collect! { |i| i ||= pool1.delete(pool1.sample) }
    child2.collect! { |i| i ||= pool2.delete(pool2.sample) }

    #return array containing both children
    [Salesman.new(child1), Salesman.new(child2)]
  end

  def flo_custom(other)
    #my own crossover algorithm, I'm not certain that it 
    #doesn't exist already somewhere else on the internet

    #it is a slight modification of the simple_swap algorithm, but it "swaps" the parents at each point 
    #their routes touch or if K dna pieces in a row from one parent have been added to one child

    ##################################################

    #pools (all islands, once for every child)
    #use own dna because it's a valid pool
    pool1 = @dna.dup
    pool2 = @dna.dup

    #children dna arrays
    child1 = Array.new(N)
    child2 = Array.new(N)

    state = true  #needed to switch between kids when assigning dna strings

    counter = 0   #needed to switch if there aren't enough matches

    (0...N).each do |n|
      if @dna[n] == other.dna[n] || counter >= K
        #change state, but only if there hasn't been a change one item before!
        state = !state if @dna[n-1] != other.dna[n-1]

        #reset counter
        counter = 0
      end
      
      #assign dna fragment depending on state to child 1 or 2
      if state
        #child 1 gets dna from parent 1 and vice-versa
        child1[n] = pool1.grep(@dna[n])[0]
        child2[n] = pool2.grep(other.dna[n])[0]

        #remove dna from both pools
        pool1.delete(@dna[n])
        pool2.delete(other.dna[n])

        #increment counter
        counter += 1
      else
        #child 1 gets dna from parent 2 and vice-versa
        child1[n] = pool1.grep(other.dna[n])[0]
        child2[n] = pool2.grep(@dna[n])[0]

        #remove dna from both pools
        pool1.delete(other.dna[n])
        pool2.delete(@dna[n])

        #increment counter
        counter += 1
      end
    end

    #fill the nils with random islands from the pools
    child1.collect! { |i| i ||= pool1.delete(pool1.sample) }
    child2.collect! { |i| i ||= pool2.delete(pool2.sample) }

    #return array containing both children
    [Salesman.new(child1), Salesman.new(child2)]
  end
end
