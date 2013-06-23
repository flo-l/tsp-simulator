require 'matrix'

class Salesman
  attr_reader :dna, :fitness

  def initialize(dna=nil)
    @dna = dna || ISLANDS.shuffle
    
    #calculate fitness
    path_lengths = []
    @dna.each_cons(2) { |islands| path_lengths << islands[0].distance_to(islands[1]) }

    #sum all the path lengths    
    @fitness = path_lengths.inject(&:+)
  end

  def <=>(other)
    @fitness <=> other.fitness
  end
end
