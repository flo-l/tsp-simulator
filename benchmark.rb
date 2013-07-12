require 'benchmark'
ARGV[0] = 'savings/test3'

puts Benchmark.measure { require './simulation.rb' }

#mri      : 51.131190
#jruby    : 24.743000
#rubinius : 44.218369
