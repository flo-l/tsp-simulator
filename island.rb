require 'matrix'

class Island
  attr_reader :location

  def initialize(x=rand(1..1000), y=rand(1..1000))
    @location = Vector[x,y]
  end

  def distance_to(other_island)
    (@location - other_island.location).magnitude
  end
end
