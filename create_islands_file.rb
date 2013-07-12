#!/usr/bin/ruby
require './configuration.rb'
require './island.rb'

#create starting point (an island actually)
starting_point = Island.new

#create n random islands
islands = Array.new(N) { Island.new }

#save:
# [0] => N
# [1] => STARTING_POINT
# [2] => ISLANDS

Marshal.dump([N, starting_point, islands], File.open(ARGV[0], "w"))
