#!/usr/bin/ruby
require 'matrix'
require './lib/island.rb'
require './lib/salesman.rb'
require './lib/population.rb'
require './lib/plotter.rb'
require './lib/project.rb'

class Simulation
  def initialize(project_name)
    #open project
    @project = Project.open(project_name)

    #create and store cost array for the starting point
    Object.const_set "FIRST", (0...N).collect { |n| ISLANDS[n].distance_to STARTING_POINT }

    #create cost matrix for the islands
    matrix = Matrix.build(N) do |i,j|
      ISLANDS[i].distance_to ISLANDS[j]
    end

    #store cost matrix
    Object.const_set "MATRIX", matrix
  end

  def simulate!(plot=true)
    #tell the user that we start!
    puts "Starting the simulation!"

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

      if fitness_new < fitness
        #save new best fitness
        fitness = fitness_new
    
        #print fitness of the best salesman
        puts fitness

        #plot path of new best salesman and write fitness to stdin
        Thread.new { Plotter.plot population.salesmen.first } if plot
      end
    end

    #plot best result (threaded because gnuplot may hang etc.)
    Thread.new { Plotter.plot population.salesmen.first }

    #save the best result in the project
    @project.save_result(population.salesmen.first)

    #neat finish
    puts "========================"
  end
end
