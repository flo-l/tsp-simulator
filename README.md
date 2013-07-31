How to use the software:
============================

###Create a project:
    ./project new NAME ISLANDS_NUM

where NAME is the desired name and ISLANDS_NUM is the desired number of islands.

This will create the folder /projects/NAME and will fill it with the following files:
 - islands (this is were the islands are saved)
 - settings.rb (settings used for simulation, should be modified to meet ones needs)
 - results (empty folder, will hold result files, they will be named after their fitness eg. 1248.81238)

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
