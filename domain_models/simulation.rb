require_relative './building'
require_relative './elevator'
require_relative './person'
require_relative './floor'

class Simulation

  attr_reader :number_of_elevators, :number_of_floors, :simulation_count, :tick_num

	def initialize(args)
		@number_of_elevators = args[:number_of_elevators]
    @number_of_floors = args[:number_of_floors]
    @simulation_count = args[:simulation_count]
    @tick_num = 1
	end

  # run the simulation @simulation_count times
	def run
    create_simulation

		@simulation_count.times do |_|
			clock_tick
    end

    puts 'End of simulation'
  end

  # At every clock tick print the simulation and call the clock_tick method on the building
  def clock_tick
    # %50 chance of generating a random new person
    create_people if (rand(2) == 0)

    print_simulation
    @building.clock_tick
    sleep(1)
    @tick_num += 1
  end

  # The building holds the collection of floors and elevators
  def create_simulation
    @building = Building.new
    @building.add_floors(create_floors)
    @building.add_elevators(create_elevators)
  end

  # Create @number_of_floors floors
  def create_floors
    floors = []
    @number_of_floors.times do |floor_number|
      floors << Floor.new(floor_number: floor_number,
                          building: @building,
                          call_buttons: @number_of_elevators)
    end
    #  Floor 1 has two waiting passenger, destined for floor 2
    floors[1].add_people(Person.new(destination_floor: 2))
    floors[1].add_people(Person.new(destination_floor: 2))
    floors
  end

  # Create @number_of_elevators elevators
  def create_elevators
    elevators = []
    @number_of_elevators.times do |elevator_number|
      elevators << Elevator.new(elevator_number: elevator_number,
                                building: @building,
                                top_floor: @number_of_floors-1)
    end
    elevators
  end

  # Create people, randomly choosing the floor they are at and the destination they want to travel to
  def create_people
    rand_origin_floor = [*0...@number_of_floors].sample
    rand_dest_floor = ([*0...@number_of_floors]-[rand_origin_floor]).sample

    @building.floors[rand_origin_floor].add_people(Person.new(destination_floor:rand_dest_floor))
  end

  # Printing a graphical representation of simulation tick
  def print_simulation
    puts "Tick #{@tick_num}:"
    puts "Floor  Elevator    Q   Done"
    # Print each floor
    (0..@number_of_floors-1).reverse_each do |i|
      queue = @building.floors[i].print_queue
      done = @building.floors[i].print_idle
      # Print elevators
      @building.elevators.each do |elevator|
        print "  #{i}\t|"
        print elevator.current_floor == @building.floors[i].floor_number ? "#{elevator.passengers.count}" : " "
      end
      print "|  \t "
      # Print passenger queue and those that are done
      printf("[%-3s][%-3s]\n", queue, done)
    end
    puts "\n"
  end
end
