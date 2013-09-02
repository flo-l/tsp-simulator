class Population
  attr_reader :salesmen

  def initialize(salesmen)
    @salesmen = salesmen
  end

  def selection_and_mutation!
    #random order during pairing
    @salesmen.shuffle!

    #pair every pair of salesmen => array of children
    children = @salesmen.each_slice(2).collect_concat { |a,b| next if b.nil? ; a.pair_with(b) }

    #mutate M % of the population
    mutants = @salesmen.sample((N*M).floor+1).dup
    mutants.each(&:mutate!)

    #keep only the best S Salesman
    #@salesmen.concat(children).concat(mutants).sort!.slice!(S..-1)
    @salesmen.concat(children).concat(mutants).sort!.pop(@salesmen.count-S)
  end
end
