class Building

	attr_reader :floors, :elevators, :elevator_calls

	def initialize
		@floors = []
    @elevators = []
    @elevator_calls = {}
	end

	def add_floors(floors)
    @floors = floors
  end

  def add_elevators(elevators)
    @elevators = elevators
  end

  def number_of_floors
    @floors.count
  end

  def number_of_elevators
    @elevators.count
  end

  def clock_tick
    @elevators.each {|elev| elev.clock_tick}
  end

  def call_elevator(floor_number)
    @elevator_calls[floor_number] = floor_number
  end

  def get_elevator_calls
    @elevator_calls.values
  end

  def remove_call(floor_number)
    @elevator_calls.delete(floor_number)
  end

  def to_s
    "Building: There are #{floors.count} floors and #{elevators.count} elevators"
  end
end

