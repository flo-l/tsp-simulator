class Population
  attr_reader :salesmen

  def initialize(salesmen)
    @salesmen = salesmen
  end

  def selection!
    #random order during pairing
    @salesmen.shuffle!

    #pair every pair of salesmen => array of children
    children = @salesmen.each_slice(2).collect_concat { |a,b| a.pair_with(b) }

    #keep only the better 50% of all individuals
    @salesmen = @salesmen.concat(children).sort[0...S]
  end

  def mutation!
    #mutate M % of the population
    @salesmen.sample((N*M).floor+1).map!(&:mutate!)
  end
end
