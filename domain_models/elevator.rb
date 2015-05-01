class Elevator

  ELEV_MAX_PERSONS = 12
  ELEV_RESTING_FLOOR = 1

  attr_reader :elevator_number, :building, :current_floor, :top_floor, :passengers, :direction

  def initialize(args)
    @elevator_number = args[:elevator_number]
    @building = args[:building]
    @top_floor = args[:top_floor]
    @current_floor = ELEV_RESTING_FLOOR
    @direction = :waiting
    @passengers = []
  end

  def clock_tick
    load_passengers(@building.floors[@current_floor])
    move
  end

  def move
    determine_direction
    if @direction == :waiting
      move_up
    elsif @direction == :up
      move_up
    elsif @direction == :down
      move_down
    elsif @direction == :idle
      travel_to_resting_floor unless @current_floor == ELEV_RESTING_FLOOR
    end
  end

  def move_up
    if @current_floor == @top_floor
      @direction = :down
      @current_floor -= 1
    else
      @direction = :up
      @current_floor += 1
    end
  end

  def move_down
    if @current_floor == 0
      @direction = :up
      @current_floor += 1
    else
      @direction = :down
      @current_floor -= 1
    end
  end

  def load_passengers(floor)
    person_queue = floor.person_queue
    person_queue.reverse_each do |person|
      if ELEV_MAX_PERSONS == person_queue.count
        puts 'Too many passengers, please wait for the elevator to get empty'
      else
        @passengers << person
        floor.enter_elevator(person)
      end
    end
    unload_passengers(floor)
  end

  def unload_passengers(floor)
    @passengers.reverse_each do |person|
      if person.destination_floor == @current_floor
        @passengers.delete(person)
        floor.exit_elevator(person)
      end
    end
  end

  def determine_direction
    calls = get_elevator_calls
    if calls.first.nil?
      @direction = :idle unless @passengers.count >= 0
    else
      calls.first >= @current_floor ? @direction = :up : @direction = :down
    end
  end

  def get_elevator_calls
    @building.get_elevator_calls
  end

  def travel_to_resting_floor
    if @current_floor > ELEV_RESTING_FLOOR
      @current_floor -= 1
    elsif @current_floor < ELEV_RESTING_FLOOR
      @current_floor += 1
    end
  end

  def max_people?
    ELEV_MAX_PERSONS
  end

  def resting_floor?
    ELEV_RESTING_FLOOR
  end

  def to_s
    "Elevator: Current floor: #{@current_floor}, Passengers: #{@passengers}, Top floor: #{@top_floor}, Resting floor: #{ELEV_RESTING_FLOOR}"
  end
end
