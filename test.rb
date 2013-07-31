

@dna = [1,2,3,4,5,6,7]

other = "a salesman"
def other.dna;[7,1,3,2,4,6,5];end

N = @dna.length

    #actually the easiest-to-implement algorithm I could think of
    #it splits the two dnas in two equally big pieces (a1,a2 and b1,b2), then tries
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
    p [child1, child2]


