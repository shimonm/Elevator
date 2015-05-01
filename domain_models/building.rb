class Building

	attr_reader :floors, :elevators, :elevator_calls

	def initialize
		@floors = []
    @elevators = []
    @elevator_calls = {}
	end

  # Building holds a collection of floors
	def add_floors(floors)
    @floors = floors
  end

  # Building holds a collection of elevators
  def add_elevators(elevators)
    @elevators = elevators
  end

  # Returns the number of floors in the Building
  def number_of_floors
    @floors.count
  end

  # Returns the number of elevators in the Building
  def number_of_elevators
    @elevators.count
  end

  # Every clock_tick is distributed to the collection of elevators
  def clock_tick
    @elevators.each {|elev| elev.clock_tick}
  end

  # Post a call for an elevator from a specific floor
  def call_elevator(floor_number)
    @elevator_calls[floor_number] = floor_number
  end

  # Get all the calls the were made back in an array
  def get_elevator_calls
    @elevator_calls.values
  end

  # After a person boarded the elevator erase the elevator call
  def remove_call(floor_number)
    @elevator_calls.delete(floor_number)
  end

  def to_s
    "Building: There are #{floors.count} floors and #{elevators.count} elevators"
  end
end

