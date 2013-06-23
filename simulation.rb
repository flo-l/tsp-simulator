require 'matrix'
load './island.rb'
load './salesman.rb'

#n => number of islands
n = 2

#s => amount of salesmen
s = 2

#c => number of runs
c = 10

#create an array of island locations (vectors)
ISLANDS = Array.new(n) { Island.new }

#create s salesmen (array)
salesmen = Array.new(s) { Salesman.new }

c.times do
  
end
