require 'fileutils'
require './lib/island.rb'

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

  def self.remove(name)
    #remove all files belonging to the project
    FileUtils.rm_r File.open(Dir.pwd + "/projects/" + name)
  end

  def initialize(name)
    #open project folder
    @folder = Dir.open(Dir.pwd + "/projects/" + name)

    #load islands (and N) from project folder
    islands = Marshal.load(File.open(@folder.path + "/islands", "r"))

    #store them globally
    Object.const_set "N", islands[0]
    Object.const_set "STARTING_POINT", islands[1]
    Object.const_set "ISLANDS", islands[2]
    
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
    Marshal.dump(result, file)

    #close the file
    file.close
  end

  def results
    #array containing the salesmen
    results = []

    #open results directory
    dir = Dir.open(@folder.path + "/results")

    dir.each do |path|
      #skip . and ..
      next if path == "." || path == ".."

      #load the results from their files and add the to the results array
      results << Marshal.load(File.open([dir.path, path].join("/"), "r"))
    end

    return results
  end
end



