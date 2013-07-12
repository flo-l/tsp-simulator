require 'matrix'

class Island
  include Comparable

  attr_reader :location

  def initialize(x=rand(1..1000), y=rand(1..1000))
    @location = Vector[x,y]
  end

  def distance_to(other_island)
    (@location - other_island.location).magnitude
  end

  def <=>(other)
    @location <=> other.location
  end

  def x
    @location[0]
  end

  def y
    @location[1]
  end
end
