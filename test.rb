#!/usr/bin/ruby
ARGV[0] = 'savings/test1'

require './plotter.rb'

#load settings from file given in ARGV[0] (marshalled)
settings = Marshal.load(File.open(ARGV[0], "r"))
N = settings[0]
STARTING_POINT = settings[1]
ISLANDS = settings[2]

#load settings from configuration file
require './configuration.rb'

#create cost array for the starting point
FIRST = (0...N).collect { |n| ISLANDS[n].distance_to STARTING_POINT }

#create cost matrix for the islands
MATRIX = Matrix.build(N) do |i,j|
  ISLANDS[i].distance_to ISLANDS[j]
end

s = Salesman.new

Plotter.plot(s)

