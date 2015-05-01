require_relative './spec_helper'

describe 'building' do

  before do
    @number_of_elevators = 1
    @number_of_floors = 5
    @building = Building.new
    elevators = []
    @number_of_elevators.times do |elevator_number|
      elevators << Elevator.new(elevator_number: elevator_number,
                                building: @building,
                                top_floor: @number_of_floors-1)
    end
    @building.add_elevators(elevators)
    floors = []
    @number_of_floors
    @number_of_floors.times do |floor_number|
      floors << Floor.new(floor_number: floor_number,
                          building: @building,
                          call_buttons: @number_of_elevators)
    end
    @building.add_floors(floors)
  end

  it 'creates a building' do
    @building.number_of_floors.must_equal 5
    @building.number_of_elevators.must_equal 1
  end

  it 'creates floors' do
    @building.floors.first.floor_number.must_equal 0
    @building.floors.last.floor_number.must_equal 4
  end

  it 'calls an elevator' do
    floor_number = 1
    @building.call_elevator(floor_number)
    @building.get_elevator_calls[0].must_equal 1
  end

  it 'removes an elevator call' do
    @building.call_elevator(1)
    @building.get_elevator_calls[0].must_equal 1
    @building.remove_call(1)
    @building.get_elevator_calls.must_be_empty
  end
end

