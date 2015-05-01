require_relative './domain_models/simulation'

print "Welcome to the simulation game!\n" 

args = {number_of_elevators: 1,
          number_of_floors: 5,
          simulation_count: 5}

simulation = Simulation.new(args)

simulation.run
