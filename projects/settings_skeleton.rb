#S => amount of salesmen
S = N**1.5232960826 #some number

#CROSSOVER => desired crossover algorithm, possible options:
# => :simple_swap
# => :scx
# => :flo_custom
CROSSOVER = :scx

#K => max. number of dna-fragments from one parent in a row during pairing (not all algorithms do support this!)
K = N/3

#M => percentage of salesmen who will mutate
M = 0.1

#C => number of runs
C = 250
