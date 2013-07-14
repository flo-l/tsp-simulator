require 'fileutils'
require './island.rb'

class Project
  attr_reader :n, :starting_point, :islands

  def self.open(name)
    #return new Project object
    Project.new(name)
  end

  def self.create(name, n)
    #create project folder
    Dir.mkdir(Dir.pwd + "/projects/" + name)

    #copy the settings skeleton
    FileUtils.copy(Dir.pwd + "/projects/settings_skeleton.rb", Dir.pwd + "/projects/" + name + "/settings.rb")

    #create empty results folder
    Dir.mkdir(Dir.pwd + "/projects/" + name + "/results")

    #create starting point (an island actually)
    starting_point = Island.new

    #create n random islands
    islands = Array.new(n) { Island.new }

    #open islands file
    file = File.open(Dir.pwd + "/projects/" + name + "/islands", "w")

    #save:
    # [0] => N
    # [1] => STARTING_POINT
    # [2] => ISLANDS
    Marshal.dump([n, starting_point, islands], file)

    #close islands file
    file.close

    #create a Project object and return it
    Project.new(name)
  end

  def initialize(name)
    #open project folder
    @folder = Dir.open(Dir.pwd + "/projects/" + name)

    #load islands (and N) from project folder
    islands = Marshal.load(File.open(@folder.path + "/islands", "r"))

    #store settings    
    @n = islands[0]
    @starting_point = islands[1]
    @islands = islands[2]
    
    #load settings from configuration file
    require @folder.path + '/settings.rb'
  end

  def save_result(result)
    #result is a salesman object
    #save fitness, to be used as filename
    fitness = result.fitness.to_s

    #find an unused file name
    while File.exists?(@folder.path + "/results/" + fitness)
      #check if the same result exists already
      if result.dna == Marshal.load(File.open(@folder.path + "/results/" + fitness, "r"))
        return true 
      else
        #append an underline to the filename
        fitness << "_"
      end
    end

    #output file
    file = File.open(@folder.path + "/results/" + fitness, "w")

    #save the result_dna into the file
    Marshal.dump(result.dna, file)

    #close the file
    file.close
  end
end



