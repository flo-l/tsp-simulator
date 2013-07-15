class Population
  attr_reader :salesmen

  def initialize(salesmen)
    @salesmen = salesmen
  end

  def selection!
    #pair all salesmen and keep only the good 50%!
    @salesmen.shuffle!

    #put children in so named array
    children = []
    @salesmen.each_cons(2) { |pair| children.concat pair[0].pair_with(pair[1]) }

    #keep only the better 50%
    @salesmen = (@salesmen + children).sort[0...S]
  end

  def mutation!
    #mutate M % of the population
    (N*M).floor+1.times do
      @salesmen.sample.mutate!
    end
  end
end
