# encoding: utf-8
require 'matrix'
require 'gnuplot'
require './lib/island.rb'
require './lib/salesman.rb'

class Plotter
  def self.plot(salesman)
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
  
        plot.title  "Fitness: " + salesman.fitness.to_s + " Crossover-algorithm: " + CROSSOVER.to_s

        #create arrays for x and y
        x = [STARTING_POINT.x]
        y = [STARTING_POINT.y]

        #fill them
        salesman.dna.each do |island_num|
          #get real island
          island = ISLANDS[island_num]
      
          #save coordinates
          x << island.x
          y << island.y
        end

        #back to starting point
        x << [STARTING_POINT.x]
        y << [STARTING_POINT.y]

        #plot islands with path
        plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
          ds.with = "linespoints"
          ds.notitle
          ds.linecolor = 1
        end

        

        #plot first island with different color
        plot.data << Gnuplot::DataSet.new( [[x.first], [y.first]] ) do |ds|
          ds.with = "points"
          ds.notitle
          ds.linecolor = 3
        end
      end
    end
  end

  def self.plot_islands(project_name)
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
  
        plot.title project_name

        #create arrays for x and y
        x = []
        y = []

        #fill them
        ISLANDS.each do |island|      
          #save coordinates
          x << island.x
          y << island.y
        end

        #plot islands without lines
        plot.data << Gnuplot::DataSet.new( [x, y] ) do |ds|
          ds.with = "points"
          ds.notitle
          ds.linecolor = 1
        end

        #plot first island with different color
        plot.data << Gnuplot::DataSet.new( [[STARTING_POINT.x], [STARTING_POINT.y]] ) do |ds|
          ds.with = "points"
          ds.notitle
          ds.linecolor = 3
        end
      end
    end
  end
end
