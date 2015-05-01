class Floor

	attr_reader :floor_number, :call_buttons, :person_queue, :building, :exiting_people

	def initialize(args)
		@floor_number = args[:floor_number]
		@call_buttons = args[:call_buttons]
    @building = args[:building]
    @person_queue = []
    @exiting_people = []
	end

	def add_people(person)
		@person_queue << person
    call_elevator
	end

  def enter_elevator(person)
    @person_queue.delete(person)
    @building.remove_call(@floor_number)
  end

  def exit_elevator(person)
    @exiting_people << person
  end

  def call_elevator
    @building.call_elevator @floor_number
  end

  def print_arr(collection)
    str = ""
    collection.each do |p|
      str += p.to_s
    end
    str
  end

  def print_queue
    print_arr @person_queue
  end

  def print_idle
    print_arr @exiting_people
  end

  def to_s
    "Floor: Floor number: #{@floor_number}, Person Queue: #{@person_queue}, Idle People: #{@exiting_people}"
  end
end

