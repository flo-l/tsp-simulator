About:
============================
This is an implementation of a genetic algorithm which solves the [Travelling Salesman Problem](https://en.wikipedia.org/wiki/Travelling_salesman_problem), the code aims to be as easy to understand as possible. 

###Short feature list:
- Genetic Algorithm
- Support for more than one crossover-algorithm
- Mutation
- Organisation of Island groups and settings in "projects"
- Comfortable command line interface
- Plotting of islands and the paths used (also intermediate results)
- Very understandable code, (too) many comments
- As modular as possible, it's very easy to implement new crossover algorithms
- Benchmark function, to compare the speed and efficiency of crossover algorithms and/or some settings


I developed the software for school, so please tell me if you find any bugs or ugly code, I would love to know how I can improve my coding style!

Installation:
============================
```
git clone https://github.com/flo-l/tsp-simulator.git
cd tsp-simulator
bundle install
```

It's highly recommended to use jruby with this software, as it seems to be about twice as fast as MRI Ruby and also 1.5 times faster than Rubinius! Install it with the following command:

    rvm install jruby

How to use the software:
============================

###Create a project:
    ./project new NAME ISLANDS_NUM

where NAME is the desired name and ISLANDS_NUM is the desired number of islands.

This will create the folder /projects/NAME and will fill it with the following files:
 - islands (this is were the islands are saved)
 - settings.rb (settings used for simulation, should be modified to meet ones needs)
 - results (empty folder, will hold result files, they will be named after their fitness eg. 1248.81238)

###Plot the island group of a project:
    ./project show NAME

where NAME is the project's name

This will show the island group of a project, without connecting lines.

###Run a simulation round
    ./project simulate NAME TIMES PLOT

where NAME is the project's name, TIMES is the number of simulation runs (optional, default is 1) and PLOT turns on plots during a simulation (on="plot", off=leave blank).

The program will write intermediate results into the terminal and plot the final result (and also intermediate ones if plotting is turned on).

Examples:
    ./project simulate some_project 4 plot

This will simulate some_project 4 times with plotting turned on.

    ./project simulate some_project 4

This will simulate some_project 4 times with plotting turned off.

    ./project simulate some_project plot

This will simulate some_project once with plotting turned on.

    ./project simulate some_project

This will simulate some_project once with plotting turned off.

###Plot results of a project
    ./project plot NAME

where NAME is the project's name.

This will plot the results of all simulations that have been made, they are saved under /projects/NAME/results.

###Remove a project
    ./project remove NAME

where NAME is the project's name

This will simply delete the projects folder. Be careful with that, because the files can't be restored (easily).
