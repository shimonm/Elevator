require_relative './spec_helper'

describe 'elevator' do

  before do
    @number_of_floors = 5
    @building = Building.new
    @elevator = Elevator.new(elevator_number: 1,
                                      building: @building,
                                      top_floor: @number_of_floors-1)
    @floor = Floor.new(floor_number: 3, building: @building)
    @building.add_floors(@floor)
    @person = Person.new(destination_floor:2)
    @floor.add_people(@person)
  end

  it 'knows its attributes' do
    @elevator.elevator_number.must_equal 1
    @elevator.max_people?.must_equal 12
    @elevator.resting_floor?.must_equal 1
  end

  it 'it can access the building from the elevator' do
    @building.must_equal @elevator.building
  end

  it 'starts in a waiting mode' do
    @elevator.direction.must_equal :waiting
  end

  it 'knows its current floor' do
    @elevator.current_floor.must_equal 1
  end

  it 'knows its top floor' do
    @elevator.top_floor.must_equal 4
  end

  it 'from a waiting mode it moves up' do
    @elevator.direction.must_equal :waiting
    @elevator.move
    @elevator.direction.must_equal :up
  end

  it 'starts to go down when it reaches the top floor' do
    3.times {|_| @elevator.move_up}
    @elevator.current_floor.must_equal 4
    @elevator.move_up
    @elevator.current_floor.must_equal 3
  end

  it 'starts to go up when it reaches the bottom floor' do
    @elevator.move_down
    @elevator.current_floor.must_equal 0
    @elevator.move_down
    @elevator.current_floor.must_equal 1
  end

  it 'loads a passenger and increases its passenger count' do
    @elevator.passengers.size.must_equal 0
    @elevator.load_passengers(@floor)
    @elevator.passengers.first.must_equal @person
  end

  it 'loads a passenger and that passenger is no longer on the floor queue' do
    @elevator.load_passengers(@floor)
    @floor.person_queue.must_be_empty
  end

  it 'unloads a passenger' do
    @elevator.move_up
    @elevator.current_floor.must_equal @person.destination_floor
    @elevator.load_passengers(@floor)
    @elevator.unload_passengers(@person.destination_floor)
    @elevator.passengers.must_be_empty
  end

  it 'determines in which direction to travel with respect to a call_elevator queue' do
    @elevator.determine_direction
    @elevator.direction.must_equal :up
    3.times {|_| @elevator.move_up}
    @elevator.determine_direction
    @elevator.direction.must_equal :down
  end

end