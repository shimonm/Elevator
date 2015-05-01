require_relative './domain_models/simulation'

print "Welcome to the simulation game!\n" #\nPlease enter the number of iterations: "
#n = $stdin.gets.chomp.to_i

args = {number_of_elevators: 1,
          number_of_floors: 5,
          simulation_count: 5}

simulation = Simulation.new(args)

simulation.run