require 'matrix'
require 'gnuplot'
require './island.rb'
require './salesman.rb'

class Plotter
  def self.plot(salesman)
    Gnuplot.open do |gp|
      Gnuplot::Plot.new( gp ) do |plot|
  
        plot.title  "Travelling Salesman Problem"
    
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
end
