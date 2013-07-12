#!/usr/bin/ruby
require 'matrix'
require './island.rb'
require './salesman.rb'
require './population.rb'
require './plotter.rb'
require './project.rb'

#load settings from project given in ARGV[0]
p = Project.open(ARGV[0]).load

#store settings
N = p.n
STARTING_POINT = p.starting_point
ISLANDS = p.islands

#create cost array for the starting point
FIRST = (0...N).collect { |n| ISLANDS[n].distance_to STARTING_POINT }

#create cost matrix for the islands
MATRIX = Matrix.build(N) do |i,j|
  ISLANDS[i].distance_to ISLANDS[j]
end

#create s salesmen (array)
salesmen = Array.new(S) { Salesman.new }

#create a population with the salesmen
population = Population.new(salesmen)

#needed as buffer
fitness = 1/0.0 #infinite

C.times do
  #select them!
  population.selection!

  #mutate M %
  population.mutation!

  #find best fitness
  fitness_new = population.salesmen.first.fitness

  #puts "#{fitness_new} < #{fitness} = #{fitness_new < fitness}"

  if fitness_new < fitness
    #save new best fitness
    fitness = fitness_new
    
    #print fitness of the best salesman
    puts fitness

    #plot path of new best salesman and write fitness to stdin
    Thread.new { Plotter.plot population.salesmen.first }
  end
end
