#!/usr/bin/ruby
require 'matrix'
require './lib/island.rb'
require './lib/salesman.rb'
require './lib/population.rb'
require './lib/plotter.rb'
require './lib/project.rb'

class Simulation
  attr_reader :project

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

  def prepare_population
    #create s salesmen (array)
    @salesmen = Array.new(S) { Salesman.new }

    #create a population with the salesmen
    @population = Population.new(@salesmen)
  end

  def simulate!(plot=true)
    #tell the user that we start!
    puts "Starting the simulation!"

    #(re)create the population
    prepare_population

    #needed as buffer
    fitness = 1/0.0 #infinite

    C.times do
      #select and mutate them!
      @population.selection_and_mutation!

      #find best salesman
      best = @population.salesmen.first

      if best.fitness < fitness
        #save new best fitness
        fitness = best.fitness
    
        #print fitness of the best salesman
        puts fitness

        #plot path of new best salesman
        Thread.new { Plotter.plot best } if plot
      end
    end

    #plot the best result if plotting is turned off
    Thread.new { Plotter.plot @population.salesmen.first } unless plot

    #save the best result in the project
    @project.save_result(@population.salesmen.first)

    #neat finish
    puts "========================"
  end

  def simulate_until(best_fitness, max_runs)
    #(re)create the population
    prepare_population

    #initialize fitness with infinite
    fitness = 1/0.0

    c = 0
    while fitness > best_fitness && c < max_runs do
      #select and mutate them!
      @population.selection_and_mutation!

      #find best fitness
      fitness = @population.salesmen.first.fitness

      #increment the rounds counter
      c += 1
    end

    #return needed runs
    c
  end
end
