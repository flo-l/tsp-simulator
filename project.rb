require 'ftools'

class Project
  attr_reader :n, :starting_point, :islands

  def self.open(name)
    new(name)
  end

  def initialize(name)
    #open project folder
    @folder = Dir.open(Dir.pwd + "/projects/" + name)
  end

  def self.create(name)
    #create project folder
    Dir.mkdir(Dir.pwd + "/projects/" + name)

    #copy the settings skeleton
    File.copy(Dir.pwd + "/projects/settings_skeleton.rb", Dir.pwd + "/projects/" + name + "/settings.rb")
  end

  def load
    #load islands (and N) from project folder
    islands = Marshal.load(File.open(@folder.path + "/islands", "r"))

    #store settings in constants    
    @n = islands[0]
    @starting_point = islands[1]
    @islands = islands[2]
    
    #load settings from configuration file
    require @folder.path + '/settings.rb'

    #return self for easier use
    return self
  end
end



